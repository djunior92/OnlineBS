import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bsmobile/uteis/server.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioPage extends StatefulWidget {
  final bool novoCadastro;

  UsuarioPage({Key key, @required this.novoCadastro}) : super(key: key);

  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

var _formKey = GlobalKey<FormState>();
var _scaffoldKey = GlobalKey<ScaffoldState>();
String nome;
String email;
String senha;
String cpfCnpj;
String endereco;
String numero;
String cep;
String bairro;
String telefone;

Future<bool> _create() async {
  var response = await http.post(URL_USUARIO,
      body: jsonEncode({'Nome': nome, 'Email': email, 'Senha': senha}),
      headers: {'Content-Type': 'application/json; charset=utf-8'});

  return response.statusCode == 200 ? true : false;
}




class _UsuarioPageState extends State<UsuarioPage> {
  @override
  initState() {
    super.initState();
    if (!widget
        .novoCadastro) //se estiver alterando os dados, então carrega as informações do usuário
    {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Usuário'),
      ),
      body: SingleChildScrollView(
        child: Container(
          //margin: EdgeInsets.fromLTRB(left, top, right, bottom),
          margin: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Visibility(
                  visible: widget.novoCadastro,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      autovalidate: false,
                      keyboardType: TextInputType.emailAddress,
                      initialValue: email,
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
                ),
                Visibility(
                  visible: widget.novoCadastro,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: TextFormField(
                      autovalidate: false,
                      obscureText: true,
                      initialValue: senha,
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
                ),
                Text(
                  'Informações comerciais',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'As Informações comerciais são obrigatórias caso você queira cadastrar um anúncio ou solicitar entrega em algum pedido.',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(fontSize: 14),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: TextFormField(
                    autovalidate: false,
                    initialValue: nome,
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
                    initialValue: cpfCnpj,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'CPF/CNPJ',
                      labelText: 'CPF/CNPJ',
                    ),
                    onSaved: (value) => cpfCnpj = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    autovalidate: false,
                    initialValue: endereco,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Endereço',
                      labelText: 'Endereço entrega/retirada',
                    ),
                    onSaved: (value) => endereco = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    autovalidate: false,
                    initialValue: numero,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Número',
                      labelText: 'Número do endereço',
                    ),
                    onSaved: (value) => numero = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    autovalidate: false,
                    initialValue: cep,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'CEP',
                      labelText: 'CEP',
                    ),
                    onSaved: (value) => cep = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    autovalidate: false,
                    initialValue: bairro,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Bairro',
                      labelText: 'Bairro',
                    ),
                    onSaved: (value) => bairro = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    autovalidate: false,
                    initialValue: telefone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Telefone',
                      labelText: 'Telefone',
                    ),
                    onSaved: (value) => telefone = value,
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
