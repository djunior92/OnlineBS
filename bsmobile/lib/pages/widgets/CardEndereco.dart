import 'dart:convert';

import 'package:bsmobile/models/Usuario.dart';
import 'package:bsmobile/pages/usuario.page.dart';
import 'package:bsmobile/pages/widgets/ListTileCustom.dart';
import 'package:bsmobile/uteis/server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CardEndereco extends StatefulWidget {
  const CardEndereco({
    Key key,
    @required this.idPessoa,
    @required this.textoTitulo,
    @required this.exibirEndereco
  }) : super(key: key);

  final String idPessoa;
  final String textoTitulo;
  final bool exibirEndereco;

  @override
  _CardEnderecoState createState() => _CardEnderecoState();
}

class _CardEnderecoState extends State<CardEndereco> {

  Usuario _usuario;

  @override
  initState() {
    super.initState();
     _loadData();
  }

  Future<void> _loadData() async {
    //recuperar o token
    var preferences = await SharedPreferences.getInstance();
    final String token = preferences.getString('token');

    //acessar a api:
    var response = await http.get(URL_USUARIO + "/" + widget.idPessoa,
      headers: {'Authorization': 'Bearer $token'},
    );

    if(response.statusCode == 200){
      Map<String, dynamic> dados = Map<String, dynamic>.from(jsonDecode(response.body));
      setState(() {
        _usuario = Usuario.fromJson(dados);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(
            widget.textoTitulo,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold
            ),
          ),
          ListTileCustom(cabecalho: "Nome:", corpo: (_usuario == null || _usuario.nome == null ? '' : _usuario.nome),
              qtdLinhaCab: 1, qtdLinhaCorp: 1),
          if (widget.exibirEndereco)
            Column(
              children: <Widget>[
                ListTileCustom(cabecalho: "Endereço:", corpo: (_usuario == null || _usuario.endereco == null ? '' : _usuario.endereco),
                    qtdLinhaCab: 1, qtdLinhaCorp: 1),
                ListTileCustom(cabecalho: "Número:", corpo: (_usuario == null || _usuario.numero == null ? '' : _usuario.numero),
                    qtdLinhaCab: 1, qtdLinhaCorp: 1),
                ListTileCustom(cabecalho: "Bairro:", corpo: (_usuario == null || _usuario.bairro == null ? '' : _usuario.bairro),
                    qtdLinhaCab: 1, qtdLinhaCorp: 1),
                ListTileCustom(cabecalho: "CEP:", corpo: (_usuario == null || _usuario.cep == null ? '' : _usuario.cep),
                    qtdLinhaCab: 1, qtdLinhaCorp: 1),
                ListTileCustom(cabecalho: "Telefone:", corpo: (_usuario == null || _usuario.telefone == null ? '' : _usuario.telefone),
                    qtdLinhaCab: 1, qtdLinhaCorp: 1)
              ],
            ),
        ],
      ),
    );
  }
}
