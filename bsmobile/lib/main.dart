import 'package:bsmobile/pages/altera.anuncio.dart';
import 'package:bsmobile/pages/anuncio.page.dart';
import 'package:bsmobile/pages/lista.anuncio.dart';
import 'package:bsmobile/pages/lista.pedido.dart';
import 'package:bsmobile/pages/menu.page.dart';
import 'package:bsmobile/pages/pedido.confirma.dart';
import 'package:bsmobile/pages/pedido.detalhe.dart';
import 'package:bsmobile/pages/pedido.escolha.page.dart';
import 'package:bsmobile/pages/pedido.page.dart';
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
    '/usuario': (context) => UsuarioPage(novoCadastro: null,),
    '/menu': (context) => MenuPage(),
    '/anuncio': (context) => AnuncioPage(),
    '/pedidoescolha': (context) => PedidoEscolhaPage(),    
    '/pedido': (context) => PedidoPage(anuncio: null,),
    '/pedidodetalhe': (context) => PedidoDetalhePage(pedido: null,),
    '/pedidolista': (context) => ListaPedidoPage(),
    '/anunciolista': (context) => ListaAnuncioPage(),
    '/anuncioaltera': (context) => AlteraAnuncioPage(anuncio: null,),
    '/confirmapedido': (context) => ConfirmaPedidoPage(anuncio: null,),
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



