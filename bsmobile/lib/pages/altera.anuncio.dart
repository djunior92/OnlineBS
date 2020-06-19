import 'package:bsmobile/models/Anuncio.dart';
import 'package:bsmobile/pages/widgets/CardInformation.dart';
import 'package:bsmobile/pages/widgets/ShowWait.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
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

    var response = await http.put(URL_ANUNCIO + "/" + widget.anuncio.id,
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

  String _formataReais(double oldValue) {
    final formatter = new NumberFormat("#,##0.00", "pt_BR");
    //final formatter = new NumberFormat.currency(locale: "pt_BR");

    //double initialValue = num.parse(oldValue.toStringAsPrecision(2));
    //return formatter.format(initialValue);
    return formatter.format(oldValue);
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
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: PhotoView(
                      backgroundDecoration:
                          BoxDecoration(color: Colors.transparent),
                      imageProvider:
                          MemoryImage(base64Decode(widget.anuncio.foto))),
                ),
                CardInformation(
                    cabecalho: 'Título',
                    corpo: widget.anuncio.titulo,
                    maxLnCorpo: 3),
                CardInformation(
                    cabecalho: 'Descrição',
                    corpo: widget.anuncio.descricao,
                    maxLnCorpo: 12),
                CardInformation(
                    cabecalho: 'Valor do produto',
                    corpo: _formataReais(widget.anuncio.valor),
                    maxLnCorpo: 1),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '* Para desativar um anúncio é necessário zerar sua quantidade disponível *',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
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
                        showWait(context); //abre dialog wait
                        bool result = await _update();
                        Navigator.of(context, rootNavigator: true)
                            .pop(true); //fecha dialog wait

                        if (result) {
                          Navigator.of(context).pop();
                        } else
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
