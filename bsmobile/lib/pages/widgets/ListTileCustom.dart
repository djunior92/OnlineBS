import 'package:flutter/material.dart';

class ListTileCustom extends StatelessWidget {

  const ListTileCustom({
    Key key,
    @required this.cabecalho,
    @required this.corpo,
    @required this.qtdLinhaCab,
    @required this.qtdLinhaCorp
  }) : super(key: key);

  final String cabecalho;
  final  String corpo;
  final int qtdLinhaCab;
  final int qtdLinhaCorp;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          cabecalho,
          textAlign: TextAlign.left,
          maxLines: qtdLinhaCab,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          corpo,
          textAlign: TextAlign.left,
          maxLines: qtdLinhaCorp,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16,
          ),
        )
    );
  }
}

