import 'planificador/test.dart';

void imprimeAlgo() {
  print("Algo");
}

void main() {
  //runApp(new MyApp());
  new Scheduler(imprimeAlgo, const Duration(milliseconds: 1000), 2);
  print("Fin....");
}
