import 'package:flutter/material.dart';
import 'package:bsmobile/models/tarefa.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TarefaItem extends StatefulWidget {
  final Tarefa tarefa;

  TarefaItem(this.tarefa);

  @override
  _TarefaItemState createState() => _TarefaItemState();
}

class _TarefaItemState extends State<TarefaItem> {
  Future<void> _update(bool concluida) async {
    //recuperar o token
    var preferences = await SharedPreferences.getInstance();
    final String token = preferences.getString('token');

    //acessar a api:
    var response = await http.put(
    'https://tarefas-api.herokuapp.com/tarefa/${widget.tarefa.id}', 
    body: jsonEncode({"nome": widget.tarefa.nome, "concluida": widget.tarefa.concluida}),
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token'
      },
    );   

    if(response.statusCode == 200) {
      setState(() {        
        widget.tarefa.concluida = concluida;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        widget.tarefa.nome,
        style: TextStyle(
          fontWeight: FontWeight.normal,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      //subtitle: widget.tarefa.concluida ? Text('concluída') : Text('aberta'),
      activeColor: Theme.of(context).primaryColor,
      value: widget.tarefa.concluida,
      //onChanged: (value) => _update(value),  //mesma coisa abaixo (simplificado)
      onChanged: _update,
          
    );
  }
}
