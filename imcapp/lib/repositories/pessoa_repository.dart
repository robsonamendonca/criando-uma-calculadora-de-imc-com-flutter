import 'package:imcapp/model/pessoa.dart';

class PessoaRepository {
  final List<Pessoa> _pessoas = [];

  Future<void> adicionar(Pessoa pessoa) async {
    await Future.delayed(const Duration(milliseconds: 100));
    pessoa.calculoDoImc(pessoa.peso, pessoa.altura);
    _pessoas.add(pessoa);
  }

  Future<void> alterar(String id, Pessoa pessoaAlterar) async {
    await Future.delayed(const Duration(milliseconds: 100));
    var pessoaOld = _pessoas.where((pessoa) => pessoa.id == id)
    .first;
    pessoaOld.setAltura(pessoaAlterar.altura);
    pessoaOld.setPeso(pessoaAlterar.peso);
    pessoaOld.calculoDoImc(pessoaAlterar.peso, pessoaAlterar.altura);
  }

  Future<void> remover(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _pessoas.remove(_pessoas.where((pessoa) => pessoa.id == id).first);
  }

  Future<List<Pessoa>> listar() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _pessoas;
  }
}
