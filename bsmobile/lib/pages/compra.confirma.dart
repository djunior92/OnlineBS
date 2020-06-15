import 'package:bsmobile/models/Anuncio.dart';
import 'package:bsmobile/pages/widgets/CardInformation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:bsmobile/uteis/server.dart';

class ConfirmaCompraPage extends StatefulWidget {
  final Anuncio anuncio;

  ConfirmaCompraPage({Key key, @required this.anuncio}) : super(key: key);

  @override
  _ConfirmaCompraPageState createState() => _ConfirmaCompraPageState();
}

class _ConfirmaCompraPageState extends State<ConfirmaCompraPage> {
  int qtdCompra;
  bool solicitaEntrega = false;

  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  int turn = 0;
  List<int> imgRotated;

  void onChanged(bool value) {
    setState(() {
      solicitaEntrega = value;
    });
  }

  @override
  initState() {
    super.initState();
  }

  Future<bool> _create() async {
    var preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');

    var response = await http.post(URL_POST_PEDIDO,
        body: jsonEncode({
          'AnuncioId': widget.anuncio.id,
          'Qtde': qtdCompra,
          'SolicitaEntrega': solicitaEntrega
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
        title: Text('Confirmação do pedido'),
      ),
      body: SingleChildScrollView(
        child: Container(
          //margin: EdgeInsets.fromLTRB(left, top, right, bottom),
          margin: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Container(
                    child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, bottom: 10, left: 5),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.anuncio.titulo.toUpperCase(),
                            textAlign: TextAlign.left,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: ListTile(
                      title: Text(
                        'Valor unitário do Produto',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14),
                      ),
                      subtitle: Text(
                        widget.anuncio.valor.toString(),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
                            'Vendedor entrega o produto?',
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14),
                          ),
                          subtitle: Checkbox(
                            value: widget.anuncio.realizaEntrega,
                            onChanged: (bool value) {
                              //onChanged(value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Informar:',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: TextFormField(
                    autovalidate: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Quantidade desejada',
                      hintText: 'Quantidade',
                    ),
                    onSaved: (value) => qtdCompra = int.parse(value),
                    validator: (value) =>
                        (value.isEmpty || int.parse(value) <= 0) ? 'Campo Obrigatório' : null,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Visibility(
                  visible: widget.anuncio.realizaEntrega,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('Solicitar entrega do produto?'),
                          Checkbox(
                            value: solicitaEntrega,
                            onChanged: (bool value) {
                              onChanged(value);
                            },
                          ),
                        ],
                      ),
                      Text(
                        '* Atenção *: Ao solicitar entrega, o produto será entregue no endereço cadastrado do perfil.',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                ButtonTheme(
                  minWidth: 300,
                  buttonColor: Theme.of(context).primaryColor,
                  textTheme: ButtonTextTheme.primary,
                  child: RaisedButton(
                    child: Text("Confirmar compra"),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        if (qtdCompra <= widget.anuncio.qtdeDisponivel) {
                          if (await _create())
                            Navigator.of(context).pop();
                          else
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text("Falha ao cadastrar"),
                              backgroundColor: Colors.red,
                            ));
                        } else {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Quantidade disponível insuficiente"),
                            backgroundColor: Colors.red,
                          ));
                        }
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
