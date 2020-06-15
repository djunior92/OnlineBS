import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardInformation extends StatelessWidget {
  const CardInformation({
    Key key,
    @required this.cabecalho,
    @required this.corpo,
    @required this.maxLnCorpo,
  }) : super(key: key);

  final String cabecalho;
  final  String corpo;
  final int maxLnCorpo;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListTile(
              title: Text(
                cabecalho,
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                corpo,
                textAlign: TextAlign.left,
                maxLines: maxLnCorpo,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}