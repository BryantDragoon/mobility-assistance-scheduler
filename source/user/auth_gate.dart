import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'pagina_principal.dart'; //Pagina con codigo de pantalla principal

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //Si no hay sesion inciada pide acceder
          if (!snapshot.hasData) {
            return SignInScreen(
              providers: [
                GoogleProvider(
                  //ClientId se consigue desde console firebase, en el sign in method de google
                    clientId:
                        "XXXXXXXXX.apps.googleusercontent.com"), 
                EmailAuthProvider(),
              ],
              headerBuilder: (context, constraints, shrinkOffset) {
                return const Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  child: Text("Aplicacion transporte propuesta", textScaleFactor: 2),
                );
              },
              subtitleBuilder: (context, action) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: action == AuthAction.signIn
                      ? const Text(
                          'Bienvenido a nuestra app de transporte, aquí puedes iniciar sesión para continuar :).')
                      : const Text(
                          'Bienvenido a nuestra app de transporte, registrate aquí si es la primer vez que accedes.'),
                );
              },
              footerBuilder: (context, action) {
                return const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Al acceder estás aceptando nuestros terminos y condiciones.',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              },
            );
          }

          //Una vez que reconoce al usuario 
          return const PaginaPrincipal(); //Envia a pagina principal
        });
  }
}
