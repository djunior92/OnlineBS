import 'dart:convert';
import 'package:intl/intl.dart';

import 'Anuncio.dart';


class Pedido {
  String id;
  String compradorId;
  //public Usuario Comprador { get; set; }
  String anuncioId;
  Anuncio anuncio;
  int qtde;
  bool solicitaEntrega;
  DateTime dataHoraPedido;
  String dataPedido;
  

  Pedido(this.id, this.compradorId, this.anuncioId, this.anuncio, this.qtde,
      this.solicitaEntrega, this.dataPedido);

  Pedido.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.compradorId = json['compradorId'];
    this.anuncioId = json['anuncioId'];
    this.qtde = json['qtde'];
    this.solicitaEntrega = json['solicitaEntrega'];
    this.dataHoraPedido = DateTime.parse(json['dataPedido']);
    this.dataPedido =  new DateFormat("dd/MM/yyyy").format(dataHoraPedido);

    this.anuncio = Anuncio.fromJson(json['anuncio']);  
  }
}
