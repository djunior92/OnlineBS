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
      body: Column(children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/anuncio');
                              },
                              child: Container(
                                width: 110,
                                height: 120,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image:
                                      AssetImage('assets/images/anuncio.png'),
                                )),
                              ),
                            ),
                            Text('Anunciar')
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/compra');
                              },
                              child: Container(
                                width: 110,
                                height: 120,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: AssetImage('assets/images/compra.png'),
                                )),
                              ),
                            ),
                            Text('Comprar')
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/anunciolista');
                              },
                              child: Container(
                                width: 100,
                                height: 120,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image:
                                      AssetImage('assets/images/findAnuncio.png'),
                                )),
                              ),
                            ),
                            Text('Anúncios criados')
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/lista');
                              },
                              child: Container(
                                width: 100,
                                height: 120,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image:
                                      AssetImage('assets/images/findCompra.png'),
                                )),
                              ),
                            ),
                            Text('Compras Realizadas')
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            Text('Editar Perfil')
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
            //RODAPÉ
            height: 100,
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/onlinebs.png'),
              //alignment: Alignment.bottomRight
            )))
      ]),
    );
  }
}
