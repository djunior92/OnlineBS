import 'package:bsmobile/models/Pedido.dart';
import 'package:bsmobile/pages/widgets/CardInformation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:convert';

import 'pedido.confirma.dart';

class PedidoDetalhePage extends StatefulWidget {
  final Pedido pedido;

  PedidoDetalhePage({Key key, @required this.pedido}) : super(key: key);

  @override
  _PedidoDetalhePageState createState() => _PedidoDetalhePageState();
}

String _formataReais(double oldValue) {
  final formatter = new NumberFormat("#,##0.00", "pt_BR");

  double initialValue = num.parse(oldValue.toStringAsPrecision(2));

  return formatter.format(initialValue);
}

class _PedidoDetalhePageState extends State<PedidoDetalhePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido'),
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
                            widget.pedido.anuncio.titulo.toUpperCase(),
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
                        _formataReais(widget.pedido.anuncio.valor),
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
                      imageProvider: MemoryImage(
                          base64Decode(widget.pedido.anuncio.foto))),
                ),
                SizedBox(
                  height: 20,
                ),
                CardInformation(
                    cabecalho: 'Informações do produto',
                    corpo: widget.pedido.anuncio.descricao,
                    maxLnCorpo: 4),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Dados da compra',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        'Data',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14),
                      ),
                      subtitle: Text(
                        widget.pedido.dataPedido,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.pedido.solicitaEntrega,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text(
                              'Você solicitou a entrega do produto',
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14),
                            ),
                            subtitle: Checkbox(
                              value: true,
                              onChanged: (bool value) {
                                //onChanged(value);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
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
                        'Qtd x Valor unitário',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14),
                      ),
                      subtitle: Text(
                        widget.pedido.qtde.toString() +
                            ' x ' +
                            _formataReais(widget.pedido.anuncio.valor),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
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
                        'Total do Pedido',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14),
                      ),
                      subtitle: Text(
                        _formataReais(
                            widget.pedido.qtde * widget.pedido.anuncio.valor),
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
                SizedBox(
                  height: 20,
                ),
                ButtonTheme(
                  minWidth: 300,
                  buttonColor: Theme.of(context).primaryColor,
                  textTheme: ButtonTextTheme.primary,
                  child: RaisedButton(
                    child: Text("Voltar"),
                    onPressed: () async {
                      Navigator.of(context).pop();
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
