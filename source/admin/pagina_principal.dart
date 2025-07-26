import 'package:flutter/material.dart';
import 'demo.dart';  //Pagina con codigo de segunda pantalla
import 'calendariocitas.dart'; //Pagina con codigo del calendario

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  int indice = 0;

  //Aqui van las opciones a donde te envia el menu
  static const List<Widget> paginaNavegacion = <Widget> [CalendarioCitas(), MyHomePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Citas programadas - Conductor"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      body: Center(
        child: paginaNavegacion.elementAt(indice),
      ),

      bottomNavigationBar: BottomNavigationBar(
        //Aqui agregas items para el menu
        items: const [
          BottomNavigationBarItem(
            label: "Agenda",
            icon: Icon(
              Icons.calendar_month,
            ),
          ),
          BottomNavigationBarItem(
            label: "Configuración",
            icon: Icon(Icons.settings),
          ),
        ],
        currentIndex: indice,
        onTap: (int pagina) {
          setState(() {
            indice = pagina;
          });
        },
      ),
    );
  }
}
