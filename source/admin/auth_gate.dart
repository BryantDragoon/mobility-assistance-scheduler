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
          //Si no hay sesion inciada
          if (!snapshot.hasData) {
            return SignInScreen(
              providers: [
                //ClientId se consigue desde console firebase, en el sign in method de google
                GoogleProvider(
                    clientId:
                        "XXXXXXXX.apps.googleusercontent.com"),
                EmailAuthProvider(),
              ],
              headerBuilder: (context, constraints, shrinkOffset) {
                return const Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  child: Text("Aplicacion transporte CONDUCTOR", textScaleFactor: 2),
                );
              },
              subtitleBuilder: (context, action) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: action == AuthAction.signIn
                      ? const Text(
                          'Esta app solo debe ser usada por el personal asignado, si eres un cliente por favor utiliza la otra aplicación.')
                      : const Text(
                          'Esta app solo debe ser usada por el personal asignado, si eres un cliente por favor utiliza la otra aplicación.'),
                );
              },
              footerBuilder: (context, action) {
                return const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Al acceder estás aceptando que tienes los permisos correspondientes, si conseguiste acceso a esta app sin ser aprovado estas violando directamente nuestros terminos y condiciones.',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              },
            );
          }

          //Una vez que reconoce al usuario
          return const PaginaPrincipal();
        });
  }
}
