import 'package:bsmobile/models/Anuncio.dart';
import 'package:bsmobile/uteis/server.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnuncioItem extends StatefulWidget {
  final Anuncio anuncio;

  AnuncioItem(this.anuncio);

  @override
  _AnuncioItemState createState() => _AnuncioItemState();
}

class _AnuncioItemState extends State<AnuncioItem> {
  Future<void> _update(bool concluida) async {
    //recuperar o token
    var preferences = await SharedPreferences.getInstance();
    final String token = preferences.getString('token');

    //acessar a api:
    var response = await http.put(
      URL_ANUNCIO + '/${widget.anuncio.id}',
      body: jsonEncode({
        "titulo": widget.anuncio.titulo,
        "descricao": widget.anuncio.descricao,
        "valor": widget.anuncio.valor,
        "qtdeDisponivel": widget.anuncio.qtdeDisponivel,
        "realizaEntrega": widget.anuncio.realizaEntrega,
        "foto": widget.anuncio.foto
      }),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        //widget.anuncio.concluida = concluida;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Material(
          borderRadius: new BorderRadius.circular(6.0),
          elevation: 2.0,
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 95,
                width: 95,
                child: PhotoView(
                    backgroundDecoration:
                        BoxDecoration(color: Colors.transparent),
                    imageProvider:
                        MemoryImage(base64Decode(widget.anuncio.foto))),
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(widget.anuncio.titulo,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  new Text(widget.anuncio.descricao,
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal)),
                  new Text(widget.anuncio.valor.toString(),
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal)),
                ],
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed('/menu');
        });
  }
}
