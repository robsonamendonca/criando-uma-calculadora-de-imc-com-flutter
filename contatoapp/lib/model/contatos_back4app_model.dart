class ContatosBack4AppModel {
  List<ContatoModel>? contatos = [];

  ContatosBack4AppModel(this.contatos);

  ContatosBack4AppModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      contatos = <ContatoModel>[];
      json['results'].forEach((v) {
        contatos!.add(ContatoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contatos != null) {
      data['results'] = contatos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContatoModel {
  String? objectId;
  String? nome;
  String? telefone;
  int? diaNascimento;
  int? mesNascimento;
  String? foto;
  String? createdAt;
  String? updatedAt;

  ContatoModel(List list,
      {this.objectId,
      this.nome,
      this.telefone,
      this.diaNascimento,
      this.mesNascimento,
      this.foto,
      this.createdAt,
      this.updatedAt});

  ContatoModel.inserir(
      {this.objectId,
      this.nome,
      this.telefone,
      this.diaNascimento,
      this.mesNascimento,
      this.foto});

  ContatoModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    nome = json['nome'];
    telefone = json['telefone'];
    diaNascimento = json['dia_nascimento'];
    mesNascimento = json['mes_nascimento'];
    foto = json['foto'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  ContatoModel.fromMap(Map map) {
    objectId = map['objectId'];
    nome = map['nome'];
    telefone = map['telefone'];
    diaNascimento = map['dia_nascimento'];
    mesNascimento = map['mes_nascimento'];
    foto = map['foto'];
    createdAt = map['createdAt'];
    updatedAt = map['updatedAt'];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      'objectId': objectId,
      'nome': nome ?? "",
      'telefone': telefone ?? "",
      'dia_nascimento': diaNascimento ?? 1,
      'mes_nascimento': mesNascimento ?? 1,
      'foto': foto,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
    if (objectId != null) {
      map['objectId'] = objectId;
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['nome'] = nome;
    data['telefone'] = telefone;
    data['dia_nascimento'] = diaNascimento;
    data['mes_nascimento'] = mesNascimento;
    data['foto'] = foto;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toJsonBody() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (objectId != "") data['objectId'] = objectId;
    data['nome'] = nome;
    data['telefone'] = telefone;
    data['dia_nascimento'] = diaNascimento;
    data['mes_nascimento'] = mesNascimento;
    data['foto'] = foto;
    return data;
  }
}
