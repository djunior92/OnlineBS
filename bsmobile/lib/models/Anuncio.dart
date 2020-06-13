import 'dart:convert';
 
class Anuncio{
  String id;
  String vendedorId;
  String titulo;
  String descricao;
  double valor;
  int qtdeDisponivel;
  bool realizaEntrega;
  String foto;
  
  Anuncio(this.id, this.vendedorId, this.titulo, this.descricao, this.valor, this.qtdeDisponivel, realizaEntrega, this.foto);

  Anuncio.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.vendedorId = json['vendedorId'];
    this.titulo = json['titulo'];
    this.descricao = json['descricao'];
    this.valor = json['valor'];
    this.qtdeDisponivel = json['qtdeDisponivel'];
    this.realizaEntrega = json['realizaEntrega'];
    this.foto = json['foto'];      
  }

  
}