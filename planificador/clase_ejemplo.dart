class Ejemplo {

  int monedas = 0;

  void _imprimeAlgo() {
    print("callback de imprimeAlgo");
  }

  void imprimeAlgo(bool finalizado) {
    this.monedas = this.monedas + 10;
    print("Monedas: ${this.monedas} y finalizado $finalizado");
    if (finalizado==true) _imprimeAlgo();
  }

  int getMonedas() { return this.monedas;}
}