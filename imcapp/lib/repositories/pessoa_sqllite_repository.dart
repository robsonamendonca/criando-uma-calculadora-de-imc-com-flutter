// ignore_for_file: non_constant_identifier_names

import 'package:imcapp/model/pessoa_sqlite_model.dart';
import 'package:imcapp/repositories/sqlitedatabase.dart';

class PessoaSQLiteRepository {
  Future<List<PessoaSQLiteModel>> obterDados() async {
    List<PessoaSQLiteModel> Pessoas = [];
    var db = await SQLiteDataBase().obterDataBase();
    var result = await db.rawQuery(
        'SELECT id, nome, data, altura, peso, imc, classificacao FROM pessoas');
    for (var element in result) {
      PessoaSQLiteModel pessoa = PessoaSQLiteModel(
        int.parse(element["id"].toString()),
        element["nome"].toString(),
        double.parse(element["peso"].toString()),
        double.parse(element["altura"].toString()),
      );
      pessoa.calculoDoImc(double.parse(element["peso"].toString()),
          double.parse(element["altura"].toString()));
      Pessoas.add(pessoa);
    }
    return Pessoas;
  }

  Future<void> salvar(PessoaSQLiteModel pessoaSQLiteModel) async {
    //ja existe alterar
    if (pessoaSQLiteModel.id > 0) {
      atualizar(pessoaSQLiteModel);
    } else {
      var db = await SQLiteDataBase().obterDataBase();
      pessoaSQLiteModel.calculoDoImc(
          pessoaSQLiteModel.peso, pessoaSQLiteModel.altura);
      await db.rawInsert(
          'INSERT INTO pessoas (nome, data, altura, peso, imc, classificacao) values(?,?,?,?,?,?)',
          [
            pessoaSQLiteModel.nome,
            pessoaSQLiteModel.data,
            pessoaSQLiteModel.altura,
            pessoaSQLiteModel.peso,
            pessoaSQLiteModel.imc,
            pessoaSQLiteModel.classificacaoImc,
          ]);
    }
  }

  Future<void> atualizar(PessoaSQLiteModel pessoaSQLiteModel) async {
    var db = await SQLiteDataBase().obterDataBase();
    pessoaSQLiteModel.calculoDoImc(
        pessoaSQLiteModel.peso, pessoaSQLiteModel.altura);
    await db.rawInsert(
        'UPDATE pessoas SET nome = ?, data= ?, altura= ?, peso= ?, imc= ?, classificacao= ? WHERE id = ?',
        [
          pessoaSQLiteModel.nome,
          pessoaSQLiteModel.data,
          pessoaSQLiteModel.altura,
          pessoaSQLiteModel.peso,
          pessoaSQLiteModel.imc,
          pessoaSQLiteModel.classificacaoImc,
          pessoaSQLiteModel.id
        ]);
  }

  Future<void> remover(int id) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.rawInsert('DELETE FROM pessoas WHERE id = ?', [id]);
  }
}
