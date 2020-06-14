import 'package:bsmobile/models/Anuncio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:bsmobile/uteis/server.dart';

class AlteraAnuncioPage extends StatefulWidget {
  final Anuncio anuncio;

  AlteraAnuncioPage({Key key, @required this.anuncio}) : super(key: key);

  @override
  _AlteraAnuncioPageState createState() => _AlteraAnuncioPageState();
}

class _AlteraAnuncioPageState extends State<AlteraAnuncioPage> {
  int qtdDisponivel;
  bool realizaEntrega = false;

  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  int turn = 0;
  List<int> imgRotated;

  void onChanged(bool value) {
    setState(() {
      realizaEntrega = value;
    });
  }

  @override
  initState() {
    super.initState();
    realizaEntrega = widget.anuncio.realizaEntrega;
  }

  Future<bool> _update() async {
    var preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');

    var response = await http.put(URL_ANUNCIO+"/"+widget.anuncio.id,
        body: jsonEncode({      
         'Titulo': widget.anuncio.titulo,
          'Descricao': widget.anuncio.descricao,
          'Valor': widget.anuncio.valor,
          'QtdeDisponivel': qtdDisponivel,
          'RealizaEntrega': realizaEntrega,
          'foto': widget.anuncio.foto
  }),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token'
        });

    return response.statusCode == 200 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Alterar Anúncio'),
      ),
      body: SingleChildScrollView(
        child: Container(
          //margin: EdgeInsets.fromLTRB(left, top, right, bottom),
          margin: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
             Container(
                    height: MediaQuery.of(context).size.height/2,
                    width: MediaQuery.of(context).size.width,
                    child: PhotoView(
                        backgroundDecoration:
                            BoxDecoration(color: Colors.transparent),
                        imageProvider:
                            MemoryImage(base64Decode(widget.anuncio.foto))),
                  ),
           
                Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          title: Text(
                            'Título',
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            widget.anuncio.titulo,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          title: Text(
                            'Descrição',
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            widget.anuncio.descricao,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          title: Text(
                            'Valor do produto',
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            widget.anuncio.valor.toString(),
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    autovalidate: false,
                    initialValue: widget.anuncio.qtdeDisponivel.toString(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Qtd. disponível',
                      labelText: 'Quantidade disponível para venda',
                    ),
                    onSaved: (value) => qtdDisponivel = int.parse(value),
                    validator: (value) =>
                        value.isEmpty ? 'Campo Obrigatório' : null,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Realiza entrega do produto?'),
                        Checkbox(
                          value: realizaEntrega,
                          onChanged: (bool value) {
                            onChanged(value);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonTheme(
                  minWidth: 300,
                  buttonColor: Theme.of(context).primaryColor,
                  textTheme: ButtonTextTheme.primary,
                  child: RaisedButton(
                    child: Text("Salvar alterações"),
                        onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save(); 

                        if (await _update())
                          Navigator.of(context).pop();
                        else
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Falha ao cadastrar"),
                            backgroundColor: Colors.red,
                          ));
                        }
                        //TODO: Salvar dados na API
                        /*_scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text("Classe:" +
                              widget.anuncio.titulo +
                              " - Edit:" +
                              titulo),
                          backgroundColor: Colors.red,
                        ));*/
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
