import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:calendar_view/calendar_view.dart' hide HeaderStyle;
import 'agendacitas.dart';
import 'evento.dart';
import 'evento_item.dart';
import 'visualizar_evento.dart';
import 'agregar_eventos.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:intl/intl.dart';

class CalendarioCitas extends StatefulWidget {
  const CalendarioCitas({super.key});

  @override
  State<CalendarioCitas> createState() => _CalendarioCitasState();
}

class _CalendarioCitasState extends State<CalendarioCitas> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late Map<DateTime, List<Event>> _events;

  //Funcion que descarga todos los eventos de la base de datos, actualmente baja el mes que se visualiza
  _loadFirestoreEvents() async {
    final firstDay = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final lastDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    _events = {};

    final snap = await FirebaseFirestore.instance
        .collection('Eventos') //Nombre que tenga la colección
        .where('HoraInicio', isGreaterThanOrEqualTo: firstDay)
        .where('HoraInicio', isLessThanOrEqualTo: lastDay)
        .withConverter(
            fromFirestore: Event.fromFirestore,
            toFirestore: (event, options) => event.toFirestore())
        .get();
    for (var doc in snap.docs) {
      final event = doc.data();
      final day = DateTime.utc(
          event.startDate.year, event.startDate.month, event.startDate.day);
      if (_events[day] == null) {
        _events[day] = [];
      }
      _events[day]!.add(event);
    }

    //Probando


    setState(() {});
  }

  //Funcion para filtrar eventos de un dia
  List _getEventsForTheDay(DateTime day) {
    return _events[day] ?? [];
  }

  //Funcion cualquier para obtener un codigo hash
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 30));
    _lastDay = DateTime.now().add(const Duration(days: 30));
    _selectedDay = DateTime.now();

    _loadFirestoreEvents();

    _events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        const Text("Calendario de fechas"),
        TableCalendar(
          headerStyle: const HeaderStyle(formatButtonVisible: false),
          firstDay: _firstDay,
          lastDay: _lastDay,
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          onPageChanged: (focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
            });
            _loadFirestoreEvents();
          },
          eventLoader: _getEventsForTheDay,
        ),
        const Text("Reservaciones agendadas:"),
        ..._getEventsForTheDay(_selectedDay).map(
          (event) {
            //Carga los eventos en el formato de agenda del dia
            final evento = CalendarEventData(
              title: "${event.user}, \n${event.orderDate}",
              titleStyle: const TextStyle(),
              date: _selectedDay,
              startTime: event.startDate,
              endTime: event.endDate,
            );

            CalendarControllerProvider.of(context).controller.add(evento);

            //Mostrando tambien la carta citas realizas, el cual entran detalles
            return EventItem(
              event: event,
              onTap: () async {
                await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetalleEvento(
                      event: event,
                    ),
                  ),
                );
                
              },
              onDelete: () async {
                final delete = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Borrar evento?"),
                    content: const Text("Estas seguro de querer eliminarlo?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                        ),
                        child: const Text("No"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
                if (delete ?? false) {
                  await FirebaseFirestore.instance
                      .collection(
                          'Eventos') //AL IGUAL QUE CUANDO AGREGA, ESCRIBIR NOMBRE DE LA COLECCION
                      .doc(event.id)
                      .delete();
                  _loadFirestoreEvents();
                }
              },
            );
          },
        ),
        ElevatedButton(
          onPressed: () async {
            await Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return AgendaDia(diaSeleccionado: _selectedDay,
                primerDia: _firstDay,
                ultimoDia: _lastDay,);
            }));

            //Cuando de agregar el evento, actualiza nuevamente
            if (mounted) {
              _loadFirestoreEvents();
            }
          },
          child: const Text("Inspeccionar dia"),
        ),
        const SizedBox(
          height: 20,
        ),
      ]),
      floatingActionButton: DraggableFab(
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push<bool>(
              context,
              MaterialPageRoute(
                builder: (_) => AddEvent(
                  firstDate: _firstDay,
                  lastDate: _lastDay,
                  selectedDate: _selectedDay,
                ),
              ),
            );
            if (result ?? false) {
              _loadFirestoreEvents();
            }
          },
          tooltip:
              "Agendar reserva para esta fecha, fecha seleccionada: ${_selectedDay.day} de ${DateFormat('MMMM').format(DateTime(0, _selectedDay.month))} de ${_selectedDay.year}",
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
