class Tarefa{
  String id;
  String usuarioId;
  String nome;
  bool concluida;
  
  Tarefa(this.id, this.usuarioId, this.nome, this.concluida);

  Tarefa.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.usuarioId = json['usuarioId'];
    this.nome = json['nome'];
    this.concluida = json['concluida'];
  }
}