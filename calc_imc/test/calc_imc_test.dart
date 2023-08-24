import 'package:calc_imc/calc_imc.dart';
import 'package:test/test.dart';

void main() {
  test('Calculo do IMC para 1 de peso e 1 de altura...', () {
    expect(calculoDoImc(1,1), "Magreza grave");
  });
  test('IMC igual a 16', () {
    expect(calculoDoImc(100,2.5), "Magreza moderada");
  });

}
