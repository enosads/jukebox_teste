class Usuario {
  String nome;
  String email;
  DateTime dataNascimento;
  String senha;
  String id;

  Usuario({this.nome, this.email, this.dataNascimento, this.senha, this.id});

  Usuario.fromMap(Map<String, dynamic> map) {
    nome = map['nome'];
    email = map['email'];
    dataNascimento = DateTime.parse(map['data_nascimento']);
    senha = map['senha'];
    id = map['_id'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['data_nascimento'] = this.dataNascimento.toString();
    data['senha'] = this.senha;
    data['_id'] = this.id;
    return data;
  }
}
