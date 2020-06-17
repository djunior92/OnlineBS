class Usuario{
  String id;
  String nome;
  String email;
  String senha;
  String cpfCnpj;
  String endereco;
  String numero;
  String cep;
  String bairro;
  String telefone;

  Usuario(this.id, this.nome, this.email, this.senha);

  Usuario.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.nome = json['nome'];
    this.email = json['email'];
    this.senha = json['senha'];
    this.cpfCnpj = json['cpfCnpj'];
    this.endereco = json['endereco'];
    this.numero = json['numero'];
    this.cep = json['cep'];
    this.bairro = json['bairro'];
    this.telefone = json['telefone'];
  }
}