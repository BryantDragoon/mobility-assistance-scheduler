import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'agregar_eventos.dart';

class AgendaDia extends StatefulWidget {
  const AgendaDia({super.key, required this.diaSeleccionado, required this.primerDia, required this.ultimoDia});

  final DateTime diaSeleccionado;
  final DateTime primerDia;
  final DateTime ultimoDia;

  @override
  State<AgendaDia> createState() => _AgendaDiaState();
}

class _AgendaDiaState extends State<AgendaDia> {
 
  late DateTime _diaSeleccionado;

  @override
  void initState() {
    super.initState();
    _diaSeleccionado = widget.diaSeleccionado;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demanda del dia"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: DayView(
        initialDay: widget.diaSeleccionado,
        heightPerMinute: 1.2,
        showHalfHours: true,    
        onPageChange: (date, page) {
          _diaSeleccionado = date;
        },
        minDay: widget.primerDia,
        maxDay: widget.ultimoDia,
       
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async{
          await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (_) => AddEvent(
                firstDate: widget.primerDia,
                lastDate: widget.ultimoDia,
                selectedDate: _diaSeleccionado,
              ),
            ),
          );

          if(mounted){
            Navigator.pop<bool>(context, true);
          }
        },
        icon: const Icon(Icons.book),
        label: const Text("Reservar"),
      ),
    );
  }
}
