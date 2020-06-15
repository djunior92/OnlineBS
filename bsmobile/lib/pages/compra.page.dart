import 'package:bsmobile/models/Anuncio.dart';
import 'package:bsmobile/pages/widgets/CardInformation.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:convert';

import 'compra.confirma.dart';

class CompraPage extends StatefulWidget {
  final Anuncio anuncio;

  CompraPage({Key key, @required this.anuncio}) : super(key: key);

  @override
  _CompraPageState createState() => _CompraPageState();
}

class _CompraPageState extends State<CompraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comprar'),
      ),
      body: SingleChildScrollView(
        child: Container(
          //margin: EdgeInsets.fromLTRB(left, top, right, bottom),
          margin: EdgeInsets.all(16),
          child: Form(
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
                        'Valor do Produto',
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
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: PhotoView(
                      backgroundDecoration:
                          BoxDecoration(color: Colors.transparent),
                      imageProvider:
                          MemoryImage(base64Decode(widget.anuncio.foto))),
                ),
                SizedBox(
                  height: 20,
                ),
                CardInformation(
                    cabecalho: 'Informações do produto',
                    corpo: widget.anuncio.descricao,
                    maxLnCorpo: 4),
                CardInformation(
                    cabecalho: 'Estoque disponível',
                    corpo: widget.anuncio.qtdeDisponivel.toString(),
                    maxLnCorpo: 1),
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
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
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
                  height: 20,
                ),
                ButtonTheme(
                  minWidth: 300,
                  buttonColor: Theme.of(context).primaryColor,
                  textTheme: ButtonTextTheme.primary,
                  child: RaisedButton(
                    child: Text("Comprar"),
                    onPressed: () async {

                     Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                            builder: (context) =>
                                                ConfirmaCompraPage(
                                                    anuncio: widget.anuncio)
                                          ));
                     
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
