import 'dart:convert';
import 'package:bsmobile/models/Anuncio.dart';
import 'package:bsmobile/uteis/server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pedido.page.dart';

class PedidoEscolhaPage extends StatefulWidget {
  @override
  _PedidoEscolhaPageState createState() => _PedidoEscolhaPageState();
}

class _PedidoEscolhaPageState extends State<PedidoEscolhaPage> {
  var _formKey = GlobalKey<FormState>();
  Future<List> _future;
  String _pesquisa = "";

  @override
  initState() {
    super.initState();
    _future = _loadData();
  }

  Future<List<Anuncio>> _loadData() async {
    //recuperar o token
    var preferences = await SharedPreferences.getInstance();
    final String token = preferences.getString('token');

    //acessar a api:
    var response = await http.get(
      URL_ANUNCIO + '/' + _pesquisa,
      headers: {'Authorization': 'Bearer $token'},
    );

    if ((response.statusCode == 200) && (_pesquisa != "")) {
      var _lista = new List<Anuncio>();

      Iterable dados = jsonDecode(response.body);
      for (var item in dados) {
        _lista.add(Anuncio.fromJson(item));
      }
      return _lista;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Procurar produtos"), actions: [
      ]),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 12,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 0, right: 0),
                      child: TextFormField(
                        autovalidate: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '',
                          labelText: 'O que você está procurando?',
                        ),
                        onSaved: (value) => _pesquisa = value,
                        validator: (value) =>
                            value.isEmpty ? 'Campo Obrigatório' : null,
                      ),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 5, left: 0, right: 0),
                      child: Wrap(
                        spacing: 12,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.search,
                              size: 40,
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                setState(() {
                                  _future = _loadData();
                                });
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                                                    flex: 3,
                                                    child: Container(
                                                      height: 95,
                                                      width: 95,
                                                      child: PhotoView(
                                                          backgroundDecoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .transparent),
                                                          imageProvider: MemoryImage(
                                                              base64Decode(snapshot
                                                                  .data[
                                                                      position]
                                                                  .foto))),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 12,
                                                    child: ListTile(
                                                      title: Text(
                                                        snapshot.data[position]
                                                            .titulo,
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
                                                            .descricao,
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
                                                              .arrow_forward)
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
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                            builder: (context) =>
                                                PedidoPage(
                                                    anuncio: snapshot
                                                        .data[position]),
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
