import 'package:cloud_firestore/cloud_firestore.dart';

//Clase evento, aqui programas los campos que desean que tenga
class Event {
  final String user;
  final String telephone;
  final String? details;
  final DateTime orderDate;
  final DateTime startDate;
  final DateTime endDate;
  final String id;

  Event({
    required this.user,
    required this.telephone,
    this.details,
    required this.orderDate,
    required this.startDate,
    required this.endDate,
    required this.id,
  });

  factory Event.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Event(
      user: data['Usuario'],
      telephone: data['Telefono'],
      startDate: data['HoraInicio'].toDate(),
      endDate: data['HoraFinalizacion'].toDate(),
      orderDate: data['FechaSolicitud'].toDate(),
      details: data['Detalles'],
      id: snapshot.id,
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      "HoraInicio": Timestamp.fromDate(startDate),
      "HoraFinalizacion": Timestamp.fromDate(endDate),
      "FechaSolicitud": Timestamp.fromDate(orderDate),
    };
  }
}