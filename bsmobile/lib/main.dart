import 'package:bsmobile/pages/altera.anuncio.dart';
import 'package:bsmobile/pages/anuncio.page.dart';
import 'package:bsmobile/pages/compra.page.dart';
import 'package:bsmobile/pages/lista.anuncio.dart';
import 'package:bsmobile/pages/menu.page.dart';
import 'package:bsmobile/pages/usuario.page.dart';
import 'package:flutter/material.dart';
import 'package:bsmobile/pages/cadastro.page.dart';
import 'package:bsmobile/pages/lista.page.dart';
import 'package:bsmobile/pages/login.page.dart';


void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  var routes = {
    '/': (context) => LoginPage(),
    '/lista': (context) => ListaPage(),
    '/cadastro': (context) => CadastroPage(),
    '/usuario': (context) => UsuarioPage(),
    '/menu': (context) => MenuPage(),
    '/anuncio': (context) => AnuncioPage(),
    '/compra': (context) => CompraPage(),    
    '/anunciolista': (context) => ListaAnuncioPage(),
    '/anuncioaltera': (context) => AlteraAnuncioPage(anuncio: null,),
    //'/cadastro/:id': (context) => CadastroPage(),
  };

    return MaterialApp(
        theme: ThemeData(
          primaryColor: const Color(0xff0daa99)
        ),
        title: 'Online BS',
        debugShowCheckedModeBanner: false,
        routes: routes,
        initialRoute: '/',
    );
  }
}



