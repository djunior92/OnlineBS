import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bsmobile/uteis/server.dart';

class UsuarioPage extends StatelessWidget {
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> _create() async {
    var response = await http.post(URL_POST_USUARIO,
        body: jsonEncode({'Nome': nome, 'Email': email, 'Senha': senha}),
        headers: {'Content-Type': 'application/json; charset=utf-8'});

    return response.statusCode == 200 ? true : false;
  }

  String nome;
  String email;
  String senha;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Novo Usuário'),
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
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    autovalidate: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nome do Usuário',
                      labelText: 'Nome',
                    ),
                    onSaved: (value) => nome = value,
                    validator: (value) =>
                        value.isEmpty ? 'Campo Obrigatório' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    autovalidate: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'E-mail  do Usuário',
                      labelText: 'E-mail',
                    ),
                    onSaved: (value) => email = value,
                    validator: (value) =>
                        value.isEmpty ? 'Campo Obrigatório' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    autovalidate: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Senha  do Usuário',
                      labelText: 'Senha',
                    ),
                    onSaved: (value) => senha = value,
                    validator: (value) =>
                        value.isEmpty ? 'Campo Obrigatório' : null,
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
