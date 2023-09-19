// ignore_for_file: unnecessary_getters_setters, prefer_final_fields

import 'package:intl/intl.dart';

class PessoaSQLiteModel {
  int _id = 0;
  String _nome = "";
  double _peso = 0.0;
  double _altura = 0.0;
  final String _data = DateFormat("dd/MM/yy").format(DateTime.now());
  double _imc = 0.0;
  String _classificacaoImc = "";

  PessoaSQLiteModel(this._id, this._nome, this._peso, this._altura);

  int get id => _id;

  set id(int id) {
    _id = id;
  }

  String get nome => _nome;

  set nome(String nome) {
    _nome = nome;
  }

  double get peso => _peso;

  set peso(double peso) {
    _peso = peso;
  }

  double get altura => _altura;

  set altura(double altura) {
    _altura = altura;
  }

  String get data => _data;

  double get imc => _imc;
  String get classificacaoImc =>_classificacaoImc;
 
  void calculoDoImc(double peso, double altura) {
    double imc = peso / (altura * altura);
    String resultado = "";
    if (imc < 16) {
      resultado = "Magreza grave";
    } else if (imc >= 16 && imc < 17) {
      resultado = "Magreza moderada";
    } else if (imc >= 17 && imc < 18.5) {
      resultado = "Magreza leve";
    } else if (imc >= 18.5 && imc < 25) {
      resultado = "Saudável";
    } else if (imc >= 25 && imc < 30) {
      resultado = "Sobrepeso";
    } else if (imc >= 30 && imc < 35) {
      resultado = "Obsidade Grau I";
    } else if (imc >= 35 && imc < 40) {
      resultado = "Obsidade Grau II (servera)";
    } else if (imc >= 40) {
      resultado = "Obsidade Grau III (mórbida)";
    } else {
      resultado = "Peso ou Alura informados são invalidos, tente novamente!";
    }
    _classificacaoImc = resultado;
    _imc = double.parse(imc.toStringAsFixed(2)); 

  }

}
