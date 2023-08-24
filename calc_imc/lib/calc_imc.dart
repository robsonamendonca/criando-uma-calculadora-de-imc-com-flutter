import 'dart:convert';
import 'dart:io';

String calculoDoImc(double peso, double altura) {
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
  print('Seu IMC esta em ${imc.toStringAsFixed(2)}, sendo assim');
  return resultado;
}

void montarTela() {
  print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
  print("-----------------------------"); // just to show where the cursor is
  print('==== CALCULADORA DO IMC ====');
  print('');
  print('IMC = PESO(KG)');
  print('     ----------');
  print('      ALTURA(M)');
  print('');
  print('Infome seus dados abaixo:');
  print('');
}

bool getContinuar() {
  bool resposta = false;
  print("Digite (c) para continuar, qualquer outra para finalizar ...");
  var line = stdin.readLineSync(encoding: utf8);
  var convt = line ?? "n";
  if (convt.toLowerCase() == "c") {
    resposta = true;
  }
  return resposta;
}
