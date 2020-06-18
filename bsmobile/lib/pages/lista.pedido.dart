import 'dart:convert';
import 'package:bsmobile/models/Pedido.dart';
import 'package:bsmobile/pages/pedido.detalhe.dart';
import 'package:bsmobile/uteis/server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListaPedidoPage extends StatefulWidget {
  @override
  _ListaPedidoPageState createState() => _ListaPedidoPageState();
}

class _ListaPedidoPageState extends State<ListaPedidoPage> {
  var _formKey = GlobalKey<FormState>();
  Future<List> _future;

  @override
  initState() {
    super.initState();
    _future = _loadData();
  }

  String _formataReais(double oldValue) {
    final formatter = new NumberFormat("#,##0.00", "pt_BR");
    //final formatter = new NumberFormat.currency(locale: "pt_BR");

    double initialValue = num.parse(oldValue.toStringAsPrecision(2));

    return formatter.format(initialValue);
  }

  Future<List<Pedido>> _loadData() async {
    //recuperar o token
    var preferences = await SharedPreferences.getInstance();
    final String token = preferences.getString('token');

    //acessar a api:
    var response = await http.get(
      URL_PEDIDO,
      headers: {'Authorization': 'Bearer $token'},
    );

    if ((response.statusCode == 200)) {
      var _lista = new List<Pedido>();

      Iterable dados = jsonDecode(response.body);
      for (var item in dados) {
        _lista.add(Pedido.fromJson(item));
      }
      return _lista;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pedidos realizados"), actions: []),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 5, left: 10, right: 10),
                child: FutureBuilder<List>(
                    future: _future,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.active:
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width,
                              child:
                                  Center(child: CircularProgressIndicator()));
                        case ConnectionState.done:
                          if (snapshot.data == null ||
                              snapshot.data.length == 0 ||
                              snapshot.hasError) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      'Nenhuma informação encontrada.',
                                      style: TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _future = _loadData();
                                      });
                                    },
                                    child: Icon(Icons.refresh)),
                              ],
                            );
                          } else {
                            return Column(
                              children: <Widget>[
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (_, int position) {
                                      final item = snapshot.data[position];

                                      return GestureDetector(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Card(
                                              child: Row(
                                                children: <Widget>[                                                 
                                                  Expanded(
                                                    flex: 12,
                                                    child: ListTile(
                                                      title: Text(
                                                        snapshot.data[position]
                                                            .anuncio.titulo,
                                                        textAlign:
                                                            TextAlign.left,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle: Text(
                                                        snapshot.data[position]
                                                                .dataPedido +
                                                            " - Total: " +
                                                            _formataReais(snapshot
                                                                    .data[
                                                                        position]
                                                                    .qtde *
                                                                snapshot
                                                                    .data[
                                                                        position]
                                                                    .anuncio
                                                                    .valor),
                                                        textAlign:
                                                            TextAlign.left,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      trailing: Wrap(
                                                        spacing: 12,
                                                        children: <Widget>[
                                                          Icon(Icons
                                                              .arrow_forward),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                            builder: (context) =>
                                                PedidoDetalhePage(
                                                    pedido: snapshot
                                                        .data[position],
                                                    listaCompra: true,),
                                          ));
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
