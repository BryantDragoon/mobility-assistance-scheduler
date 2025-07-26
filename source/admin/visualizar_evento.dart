import 'package:flutter/material.dart';
import 'evento.dart';

//Aqui se despliega la información completa del evento, donde los detalles solo son vistos por los usuarios asignados 

class DetalleEvento extends StatefulWidget {

  final Event event;

  const DetalleEvento({super.key, required this.event});

  @override
  State<DetalleEvento> createState() => _DetalleEventoState();
}

class _DetalleEventoState extends State<DetalleEvento> {

  final _telefonoController = TextEditingController();
  final  _seleccionFecha = TextEditingController();
  final _detallesController = TextEditingController();
  final _nombreController = TextEditingController();
  final _horaInicioController = TextEditingController();
  final _horaFinalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _telefonoController.text = widget.event.telephone ;
    _seleccionFecha.text = widget.event.orderDate.toString();
    _horaInicioController.text = widget.event.startDate.toString();
    _horaFinalController.text = widget.event.endDate.toString();
    _nombreController.text = widget.event.user ;
    _detallesController.text = widget.event.details.toString();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles del evento"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextField(
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Fecha que se realizó solicitud"),
            ),
            controller: _seleccionFecha,
          ),
          const SizedBox(height: 10),
          TextField(
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Hora de inicio"),
            ),
            controller: _horaInicioController,
          ),
          const SizedBox(height: 10),
          TextField(
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Hora de finalización estimada"),
            ),
            controller: _horaFinalController,
          ),
          const SizedBox(height: 10),
          TextField(
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Nombre del usuario"),
            ),
            controller: _nombreController,
          ),
          const SizedBox(height: 10),
          TextField(
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Teléfono"),
            ),
            controller: _telefonoController,
          ),
          const SizedBox(height: 10),
          TextField(
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Detalles proporcionados"),
            ),
            controller: _detallesController,
            maxLines: 4,
          ),
          const SizedBox(height: 10),
          
        ]
      ),
    );
  }
}