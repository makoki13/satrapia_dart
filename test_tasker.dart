import 'planificador/test.dart';
import 'planificador/clase_ejemplo.dart';

void main() {
  
  Ejemplo ejemplo = new Ejemplo();

  new Scheduler(ejemplo.imprimeAlgo, const Duration(milliseconds: 1000), 1);
  print("Fin.... total de Monedas ${ejemplo.getMonedas()}");
}
