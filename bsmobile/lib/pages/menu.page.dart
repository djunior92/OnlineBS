import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bsmobile/uteis/server.dart';


class MenuPage extends StatelessWidget {
  void _portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Future<void> _logout(BuildContext context) async {
    var preferences = await SharedPreferences.getInstance();
    preferences.setString('token', '');
    Navigator.of(context).pushReplacementNamed('/');
  }   

  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();

    return Scaffold(
      appBar: AppBar(
        title: Text('Bem vindo!', style: TextStyle(color: Colors.white)),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _logout(context);
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.height / 2,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/anuncio');
                                },
                                child: Container(
                                  width: 100,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image:
                                        AssetImage('assets/images/anuncio.png'),
                                  )),
                                ),
                              ),
                              Text(
                                'Anunciar',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/compra');
                                },
                                child: Container(
                                  width: 100,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image:
                                        AssetImage('assets/images/compra.png'),
                                  )),
                                ),
                              ),
                              Text(
                                'Comprar',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  //Navigator.of(context).pushNamed('/perfil');
                                },
                                child: Container(
                                  width: 100,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image:
                                        AssetImage('assets/images/profile.png'),
                                  )),
                                ),
                              ),
                              Text('Perfil')
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  //Navigator.of(context).pushNamed('/historico');
                                },
                                child: Container(
                                  width: 100,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: AssetImage(
                                        'assets/images/historico.png'),
                                  )),
                                ),
                              ),
                              Text('Histórico')
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
          Container(
              //RODAPÉ
              height: 100,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/onlinebs.png'),
                //alignment: Alignment.bottomRight
              ))),
        ],
      ),
    );
  }
}
