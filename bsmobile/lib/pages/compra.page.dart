import 'package:flutter/material.dart';



class CompraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

   return Scaffold(
      appBar: AppBar(
        title: Text('Realizar Compra', style: TextStyle(color: Colors.white)),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.exit_to_app),
            onPressed: () {},
          )
        ],
      ),
      body: Column(),
   );
  }
}



