import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Pessoa {
  final String _id = UniqueKey().toString();
  final String _data = DateFormat("dd/MM/yy").format(DateTime.now());
  double _imc = 0.0;
  String _classificacaoImc = "";

  double _peso = 0.0;
  double _altura = 0.0;

  Pessoa(this._peso, this._altura);

  String get id => _id;
  String get data => _data;
  String get classificaoImc => _classificacaoImc;
  double get peso => _peso;
  double get altura => _altura;
  double get imc => _imc;

  void setPeso(double peso) {
    _peso = peso;
  }

  void setAltura(double altura) {
    _altura = altura;
  }
  
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

  @override
  String toString() {
    return {"IMC": _imc, "Peso": _peso, "Altura": _altura}.toString();
  }
}
