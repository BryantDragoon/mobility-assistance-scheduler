import 'package:flutter/material.dart';
import 'evento.dart';

//Asigna el evento a una tarjeta interactiva

class EventItem extends StatelessWidget {
  final Event event;
  final Function() onDelete;
  final Function()? onTap;
  const EventItem({
    Key? key,
    required this.event,
    required this.onDelete,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        event.user,
      ),
      subtitle: Text(
        "Desde ${event.startDate.toString()} \nHasta: ${event.endDate.toString()}",
      ),
      onTap: onTap,
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
      isThreeLine: true,
    );
  }
}