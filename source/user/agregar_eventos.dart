import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//Aqui se define la pantalla de agregar evento, y la funcion que manda llamar para subirlos a la base de datos

class AddEvent extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? selectedDate;

  const AddEvent(
      {Key? key,
      required this.firstDate,
      required this.lastDate,
      this.selectedDate})
      : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  late DateTime _selectedDate;
  final _telefonoController = TextEditingController();
  final _detallesController = TextEditingController();
  final _nombreController = TextEditingController();
  final _horaInicioController = TextEditingController();
  late TimeOfDay? horaInicio;
  final _horaFinalController = TextEditingController();
  late TimeOfDay? horaFinal;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reservar vehiculo")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          InputDatePickerFormField(
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            initialDate: _selectedDate,
            onDateSubmitted: (date) {
              setState(() {
                _selectedDate = date;
              });
            },
          ),
          const SizedBox(height: 10),
          TextField(
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Horario de inicio"),
            ),
            onTap: () async {
              horaInicio = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: false),
                    child: child ?? Container(),
                  );
                },
              );
              horaInicio ??= TimeOfDay.now();
              setState(() {
                _horaInicioController.text = horaInicio!.format(context);
              });
            },
            controller: _horaInicioController,
          ),
          const SizedBox(height: 10),
          TextField(
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Horario de finalización estimado"),
            ),
            onTap: () async {
              horaFinal = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(
                    DateTime.now().add(const Duration(hours: 1))),
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: false),
                    child: child ?? Container(),
                  );
                },
              );
              horaFinal ??= TimeOfDay.fromDateTime(
                  DateTime.now().add(const Duration(hours: 1)));
              setState(() {
                _horaFinalController.text = horaFinal!.format(context);
              });
            },
            controller: _horaFinalController,
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Nombre completo"),
            ),
            controller: _nombreController,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _telefonoController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Teléfono',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _detallesController,
            maxLines: 3,
            decoration: const InputDecoration(
                labelText: 'Detalles',
                border: OutlineInputBorder(),
                hintText:
                    "Actividades planeadas, Impedimentos físicos que presentes, cuidados especiales que requieras, etc. Entre más detalles mejor.",
                hintStyle: TextStyle(color: Colors.grey)),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              _addEvent();
            },
            child: const Text("Confirmar reserva"),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
              "*Toma en cuenta los horarios de reserva realizados por los demás usuarios, SÍ es posible solicitar un periodo ya utilizado, pero la confirmación dependerá de la disponibilidad de conductores, y se dá prioridad al evento agendado primero*"),
        ],
      ),
    );
  }

  //Funcion que sube los eventos
  void _addEvent() async {
    final telefono = _telefonoController.text;
    if (telefono.isEmpty) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Olvidaste agregar tu teléfono'),
          content: const Text(
              'Es muy importante que el campo de teléfono no se encuentre vacío, ya que es el medio que usamos para poderte contactar por cualquier duda o problema que surja.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Enterado'),
              child: const Text('Enterado'),
            ),
          ],
        ),
      );
      return;
    }
    await FirebaseFirestore.instance.collection('Eventos').add({
      "Usuario": _nombreController.text,
      "Telefono": telefono,
      "Detalles": _detallesController.text,
      "HoraInicio": Timestamp.fromDate(DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          horaInicio!.hour,
          horaInicio!.minute)),
      "HoraFinalizacion": Timestamp.fromDate(DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          horaFinal!.hour,
          horaFinal!.minute)),
      "FechaSolicitud": Timestamp.fromDate(DateTime.now()),
    });

    if (mounted) {
      Navigator.pop<bool>(context, true);
    }
  }
}
