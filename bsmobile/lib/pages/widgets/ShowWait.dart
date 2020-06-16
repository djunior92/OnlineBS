import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showWait(context) {
  showDialog(
    barrierDismissible: true,
      context: context,
      child: WillPopScope(
          onWillPop: () async => false,
          child:BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: MediaQuery.of(context).size.width / 5,
                      width: MediaQuery.of(context).size.width / 5,
                      child: CircularProgressIndicator()),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Aguarde",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ))));
}
