import 'package:bsmobile/models/Usuario.dart';
import 'package:bsmobile/pages/widgets/ShowWait.dart';
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

String idUsuario = "";

final _emailController = TextEditingController();
final _senhaController = TextEditingController();
final _nomeController = TextEditingController();
final _cpfCnpjController = TextEditingController();
final _enderecoController = TextEditingController();
final _numeroController = TextEditingController();
final _cepController = TextEditingController();
final _bairroController = TextEditingController();
final _telefoneController = TextEditingController();

Future<bool> _create() async {
  var response = await http.post(URL_USUARIO,
      body: jsonEncode(toJson()),
      headers: {'Content-Type': 'application/json; charset=utf-8'});

  return response.statusCode == 200 ? true : false;
}

Map<String, dynamic> toJson() => {
      'email': _emailController.text,
      'senha': _senhaController.text,
      'nome': _nomeController.text,
      'cpfCnpj': _cpfCnpjController.text,
      'endereco': _enderecoController.text,
      'numero': _numeroController.text,
      'cep': _cepController.text,
      'bairro': _bairroController.text,
      'telefone': _telefoneController.text
    };

Future<bool> _editar() async {
  var response = await http.put(URL_USUARIO + '/' + idUsuario,
      body: jsonEncode(toJson()),
      headers: {'Content-Type': 'application/json; charset=utf-8'});

  return response.statusCode == 200 ? true : false;
}

class _UsuarioPageState extends State<UsuarioPage> {
  @override
  initState() {
    super.initState();
    if (widget
        .novoCadastro) //se estiver alterando os dados, então carrega as informações do usuário
      _limparCampos();
    else
      _loadData();
  }

  void _limparCampos() {
    _emailController.text = "";
    _senhaController.text = "";
    _nomeController.text = "";
    _cpfCnpjController.text = "";
    _enderecoController.text = "";
    _numeroController.text = "";
    _cepController.text = "";
    _bairroController.text = "";
    _telefoneController.text = "";
  }

  Future<void> _loadData() async {
    //recuperar o token
    var preferences = await SharedPreferences.getInstance();
    final String token = preferences.getString('token');

    //acessar a api:
    var response = await http.get(
      URL_USUARIO,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> dados =
          Map<String, dynamic>.from(jsonDecode(response.body));
      Usuario _usuario = Usuario.fromJson(dados);
      setState(() {
        idUsuario = _usuario.id;
        _emailController.text = _usuario.email;
        _senhaController.text = _usuario.senha;
        _nomeController.text = _usuario.nome;
        _cpfCnpjController.text = _usuario.cpfCnpj;
        _enderecoController.text = _usuario.endereco;
        _numeroController.text = _usuario.numero;
        _cepController.text = _usuario.cep;
        _bairroController.text = _usuario.bairro;
        _telefoneController.text = _usuario.telefone;
      });
    } //else if(response.statusCode == 401){
    //  Navigator.of(context).pushReplacementNamed('/');
    //}
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
                      maxLength: 30,
                      keyboardType: TextInputType.emailAddress,
                      //initialValue: email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'E-mail  do Usuário',
                        labelText: 'E-mail',
                      ),
                      //onSaved: (value) => email = value,
                      controller: _emailController,
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
                      maxLength: 30,
                      //initialValue: senha,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Senha  do Usuário',
                        labelText: 'Senha',
                      ),
                      //onSaved: (value) => senha = value,
                      controller: _senhaController,
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
                    maxLength: 100,
                    //initialValue: nome,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nome do Usuário',
                      labelText: 'Nome',
                    ),
                    //onSaved: (value) => nome = value,
                    controller: _nomeController,
                    validator: (value) =>
                        value.isEmpty ? 'Campo Obrigatório' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    autovalidate: false,
                    //initialValue: cpfCnpj,
                    maxLength: 14,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'CPF/CNPJ',
                      labelText: 'CPF/CNPJ',
                    ),
                    //onSaved: (value) => cpfCnpj = value,
                    controller: _cpfCnpjController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    autovalidate: false,
                    maxLength: 100,
                    //initialValue: endereco,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Endereço',
                      labelText: 'Endereço entrega/retirada',
                    ),
                    //onSaved: (value) => endereco = value,
                    controller: _enderecoController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    autovalidate: false,
                    maxLength: 6,
                    //initialValue: numero,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Número',
                      labelText: 'Número do endereço',
                    ),
                    //onSaved: (value) => numero = value,
                    controller: _numeroController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    autovalidate: false,
                    maxLength: 8,
                    //initialValue: cep,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'CEP',
                      labelText: 'CEP',
                    ),
                    //onSaved: (value) => cep = value,
                    controller: _cepController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    autovalidate: false,
                    maxLength: 50,
                    //initialValue: bairro,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Bairro',
                      labelText: 'Bairro',
                    ),
                    //onSaved: (value) => bairro = value,
                    controller: _bairroController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    autovalidate: false,
                    maxLength: 14,
                    //initialValue: telefone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Telefone',
                      labelText: 'Telefone',
                    ),
                    //onSaved: (value) => telefone = value,
                    controller: _telefoneController,
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

                        showWait(context); //abre dialog wait
                        bool result =
                            await (widget.novoCadastro ? _create() : _editar());
                        Navigator.of(context, rootNavigator: true)
                            .pop(true); //fecha dialog wait

                        if (result)
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
