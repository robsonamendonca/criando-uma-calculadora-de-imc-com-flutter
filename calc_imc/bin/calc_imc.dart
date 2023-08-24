import 'dart:convert';
import 'dart:io';

import 'package:calc_imc/calc_imc.dart' as calc_imc;
import 'package:calc_imc/classes/pessoa.dart';

void main() {
  bool continuar = false;
  do {
    calc_imc.montarTela();
    print("Informe o nome da pessoa :");
    var nome = stdin.readLineSync(encoding: utf8);
    try {
      if (nome!.trim() == "") {
        throw "Informe um nome valido antes de continuar";
      }
    } catch (e) {
      print(e);
      exit(0);
    }

    print("Informe o peso(kg - ex.: 80.1) da pessoa :");
    var peso = stdin.readLineSync(encoding: utf8);
    print("Informe o altura(m2 - ex.: 1.65) da pessoa :");
    var altura = stdin.readLineSync(encoding: utf8);
    try {
      var cvtPeso = double.parse(peso ?? "0");
      var cvtAltura = double.parse(altura ?? "0");
      var pessoa = Pessoa(nome,cvtPeso, cvtAltura );
      print("Olá, ${pessoa.getNome()}, sua classificação é ");
      print(calc_imc.calculoDoImc(cvtPeso, cvtAltura));
    } catch (e) {
      print(e);
      exit(0);
    }
    print('');
    continuar = calc_imc.getContinuar();
  } while (continuar == true);
  print('Obrigado!');
}
