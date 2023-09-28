// ignore_for_file: unnecessary_getters_setters

class ConfiguracoesModel {
  String _nomeUsuario = "";
  String _emailUsuario = "";
  String _idioma = "";
  int _ordemLista = 0;
  bool _exibirContador=false;

  ConfiguracoesModel.vazio() {
    _nomeUsuario = "";
    _emailUsuario = "";
    _idioma = "";
    _ordemLista = 0;
    _exibirContador = false;
  }
  ConfiguracoesModel(
    this._nomeUsuario,
    this._emailUsuario,
    this._idioma,
    this._ordemLista,
    this._exibirContador
  );

  String get nomeUsuario => _nomeUsuario;

  set nomeUsuario(String nomeUsuario) {
    _nomeUsuario = nomeUsuario;
  }

  String get email => _emailUsuario;

  set emailUsuario(String email) {
    _emailUsuario = email;
  }

  String get idioma => _idioma;

  set idioma(String idioma) {
    _idioma = idioma;
  }

  int get ordemLista => _ordemLista;

  set ordemLista(int ordemLista) {
    _ordemLista = ordemLista;
  }

    bool get exibirContador => _exibirContador;

  set exibirContador(bool exibirContador) {
    _exibirContador = exibirContador;
  }
}
