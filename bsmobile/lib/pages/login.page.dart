import 'package:bsmobile/pages/usuario.page.dart';
import 'package:bsmobile/pages/widgets/ShowWait.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bsmobile/uteis/server.dart';

class LoginPage extends StatelessWidget {
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  String email;
  String senha;

  Future<bool> _login() async {
    var result = false;
    try {
      var response = await http.post(URL_LOGIN,
          body: jsonEncode({'email': email, 'senha': senha}),
          headers: {'Content-Type': 'application/json; charset=utf-8'});

      if (response.statusCode == 200) {
        var token = jsonDecode(response.body)['token'];
        var preferences = await SharedPreferences.getInstance();
        preferences.setString('token', token);
        result = true;

      } else if (response.statusCode == 401) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
              "Email e/ou senha inválidos. Verifique os dados informados."),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
            "Erro: "+"Não foi possível conectar ao servidor."),
        backgroundColor: Colors.red,
      ));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      //appBar: AppBar(
      //  title: Text('Login'),
      //),
      body: SingleChildScrollView(
        child: Container(
          //margin: EdgeInsets.fromLTRB(left, top, right, bottom),
          margin: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, top: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/onlinebs.png'),
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.center)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text('Informe email e senha para prosseguir:',
                      style: TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    autovalidate: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'E-mail',
                      icon: Icon(Icons.mail_outline),
                      hintText: 'E-mail',
                    ),
                    onSaved: (value) => email = value,
                    validator: (value) =>
                        value.isEmpty ? 'Campo Obrigatório' : null,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    autovalidate: false,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                      icon: Icon(Icons.vpn_key),
                    ),
                    onSaved: (value) => senha = value,
                    validator: (value) =>
                        value.isEmpty ? 'Campo Obrigatório' : null,
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),              
                ButtonTheme(
                  minWidth: double.infinity,
                  buttonColor: Theme.of(context).primaryColor,
                  textTheme: ButtonTextTheme.primary,
                  child: RaisedButton(
                    child: Text("Entrar"),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        //TODO: Salvar dados na API

                        showWait(context); //abre dialog wait
                        bool result = await _login();
                        Navigator.of(context, rootNavigator: true)
                            .pop(true); //fecha dialog wait
                        if (result)
                          Navigator.of(context).pushReplacementNamed(
                              '/menu'); //deixando como "tela principal"
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                      child: Text('Ainda não tem conta? Cadastre-se!',
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                      onTap: () {
                        //Navigator.of(context).pushNamed('/usuario');
                         Navigator.of(context).push(
                                              MaterialPageRoute(
                                            builder: (context) =>
                                                UsuarioPage(
                                                    novoCadastro: true,
                                          )));
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
