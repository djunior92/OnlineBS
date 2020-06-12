import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:bsmobile/uteis/camera.dart';
import 'package:bsmobile/uteis/server.dart';

class AnuncioPage extends StatefulWidget {
  @override
  _AnuncioPageState createState() => _AnuncioPageState();
}

class _AnuncioPageState extends State<AnuncioPage> {
  String titulo;
  String descricao;
  double valor;
  int qtdDisponivel;
  bool realizaEntrega = false;
  String foto;

  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  int turn = 0;
  List<int> _image;
  List<int> imgRotated;

  void onChanged(bool value) {
    setState(() {
      realizaEntrega = value;
    });
  }

  Future<bool> _create() async {
    var preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');

    var response = await http.post(URL_POST_ANUNCIO,
        body: jsonEncode({
          'Titulo': titulo,
          'Descricao': descricao,
          'Valor': valor,
          'QtdeDisponivel': qtdDisponivel,
          'RealizaEntrega': realizaEntrega,
          'foto': base64Encode(imgRotated)
        }),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token'
        });

    return response.statusCode == 200 ? true : false;
  }

  Future<void> showImgDialog() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.all(0.0),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Column(
                  //height: MediaQuery.of(context).size.height,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                        flex: 7,
                        child: ClipRect(
                            child: PhotoView(
                                backgroundDecoration:
                                    BoxDecoration(color: Colors.transparent),
                                imageProvider: MemoryImage(imgRotated)))),
                    Expanded(
                        flex: 1,
                        child: RaisedButton(
                            onPressed: () async {
                              try {
                                turn++;
                                imgRotated =
                                    await rotateImage(_image, turn * -90);
                                setState(() {
                                  /*if (aux != null) {
                                    _image = aux;
                                  }*/
                                });
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Container(
                              width: double
                                  .maxFinite, //MediaQuery.of(context).size.width,
                              child: Row(
                                //mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.rotate_left),
                                  Text(
                                    'Girar',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                            ))),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _offsetPopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text(
              "Capturar Foto",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Text(
              "Galeria",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
        ],
        onSelected: (choice) async {
          getImage(choice, 70).then((value) {
            setState(() {
              _image = value;
              turn = 0;
              imgRotated = value;
            });
          });
        },
        icon: Icon(Icons.camera),
        //offset: Offset(-0.1, 0),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar( 
        title: Text('Cadastrar Anúncio'),
      ),
      body: SingleChildScrollView(
        child: Container(
          //margin: EdgeInsets.fromLTRB(left, top, right, bottom),
          margin: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    autovalidate: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Título',
                      labelText: 'Título do Anúncio',
                    ),
                    onSaved: (value) => titulo = value,
                    validator: (value) =>
                        value.isEmpty ? 'Campo Obrigatório' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    autovalidate: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Descrição',
                      labelText: 'Descrição complementar',
                    ),
                    onSaved: (value) => descricao = value,
                    validator: (value) =>
                        value.isEmpty ? 'Campo Obrigatório' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    autovalidate: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Valor',
                      labelText: 'Valor do produto',
                    ),
                    onSaved: (value) => valor = double.parse(value),
                    validator: (value) =>
                        value.isEmpty ? 'Campo Obrigatório' : null,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      BlacklistingTextInputFormatter(new RegExp('[\\-|\\ ]'))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    autovalidate: false,
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
                  height: 16,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: ListTile(
                      leading: imgRotated != null
                          ? GestureDetector(
                              child: Image.memory(imgRotated),
                              onTap: () async {
                                await showImgDialog();

                                if (turn > 0) {
                                  setState(() {});
                                }
                              },
                            )
                          : _offsetPopup(),
                      title: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                              imgRotated == null
                                  ? 'Insira uma foto.'
                                  : 'Foto capturada.',
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ),
                      ),
                      trailing: imgRotated != null
                          ? GestureDetector(
                              child: new Icon(Icons.delete),
                              onTap: () async {
                                setState(() {
                                  turn = 0;
                                  _image = null;
                                  imgRotated = null;
                                });
                              },
                            )
                          : Container(height: 0, width: 0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                ButtonTheme(
                  minWidth: 300,
                  buttonColor: Theme.of(context).primaryColor,
                  textTheme: ButtonTextTheme.primary,
                  child: RaisedButton(
                    child: Text("Salvar"),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        //TODO: Salvar dados na API
                        if (await _create())
                          Navigator.of(context).pop();
                        else
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Falha ao cadastrar"),
                            backgroundColor: Colors.red,
                          ));
                      }
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
