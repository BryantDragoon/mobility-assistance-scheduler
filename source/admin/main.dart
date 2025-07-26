import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth_gate.dart'; //Pagina con codigo de pantalla de autentificacion
import 'firebase_options.dart';

//AQUI COMIENZA 
void main() async {
  //CARGA RECURSOS
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); 

  //COMIENZA A CORRER APP
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return CalendarControllerProvider(
      controller: EventController(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  const AuthGate(), //ENVIA PRIMERAMENTE A LA PANTALLA DE AUTENTIFICACION
      ),
    );
  }
}
