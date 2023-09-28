// ignore_for_file: constant_identifier_names, camel_case_types

import 'package:shared_preferences/shared_preferences.dart';

enum STORAGE_CHAVES {
  CHAVE_NOME_USUARIO,
  CHAVE_EMAIL_USUARIO,
  CHAVE_ORDEM_LISTA,
  CHAVE_IDIOMA_APP,
  CHAVE_EXIBIR_CONTADOR,
  CHAVE_QTDE_CONTATOS,
  CHAVE_QTDE_ANIVER
}

class AppStorageService {
  Future<void> setConfiguracoesNomeUsuario(String nome) async {
    await _setString(STORAGE_CHAVES.CHAVE_NOME_USUARIO.toString(), nome);
  }

  Future<String> getConfiguracoesNomeUsuario() async {
    return _getString(STORAGE_CHAVES.CHAVE_NOME_USUARIO.toString());
  }

  Future<void> setConfiguracoesEmailUsuario(String email) async {
    await _setString(STORAGE_CHAVES.CHAVE_EMAIL_USUARIO.toString(), email);
  }

  Future<String> getConfiguracoesEmailUsuario() async {
    return _getString(STORAGE_CHAVES.CHAVE_EMAIL_USUARIO.toString());
  }

  Future<void> setConfiguracoesOrdemLista(int ordem) async {
    await _setInt(STORAGE_CHAVES.CHAVE_ORDEM_LISTA.toString(), ordem);
  }

  Future<int> getConfiguracoesOrdemLista() async {
    return _getInt(STORAGE_CHAVES.CHAVE_ORDEM_LISTA.toString());
  }

  Future<void> setConfiguracoesQtdeContatos(int qtd) async {
    await _setInt(STORAGE_CHAVES.CHAVE_QTDE_CONTATOS.toString(), qtd);
  }

  Future<int> getConfiguracoesQtdeContatos() async {
    return _getInt(STORAGE_CHAVES.CHAVE_QTDE_CONTATOS.toString());
  }
    Future<void> setConfiguracoesQtdeAniver(int qtde) async {
    await _setInt(STORAGE_CHAVES.CHAVE_QTDE_ANIVER.toString(), qtde);
  }

  Future<int> getConfiguracoesQtdeAniver() async {
    return _getInt(STORAGE_CHAVES.CHAVE_QTDE_ANIVER.toString());
  }

  Future<void> setConfiguracoesIdioma(String idioma) async {
    await _setString(STORAGE_CHAVES.CHAVE_IDIOMA_APP.toString(), idioma);
  }

  Future<String> getConfiguracoesIdioma() async {
    return _getString(STORAGE_CHAVES.CHAVE_IDIOMA_APP.toString());
  }

  Future<void> setConfiguracoesExibirContador(bool value) async {
    await _setBool(STORAGE_CHAVES.CHAVE_EXIBIR_CONTADOR.toString(), value);
  }

  Future<bool> getConfiguracoesExibirContador() async {
    return _getBool(STORAGE_CHAVES.CHAVE_EXIBIR_CONTADOR.toString());
  }

  Future<void> _setBool(String chave, bool value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setBool(chave, value);
  }

  Future<bool> _getBool(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getBool(chave) ?? false;
  }

  Future<void> _setString(String chave, String value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setString(chave, value);
  }

  Future<String> _getString(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(chave) ?? "";
  }

  Future<void> _setInt(String chave, int value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setInt(chave, value);
  }

  Future<int> _getInt(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getInt(chave) ?? 0;
  }
}
