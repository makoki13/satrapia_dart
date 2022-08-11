import './Recurso.clase.dart';
import './Punto.clase.dart';

class Productor {
  Punto _posicion;
  Recurso _recurso;

  //cantidad que queda en el filon
  late int _stock;

  // cantidad inicial del filon
  int _stock_inicial;
  double _ratio_produccion;

  Productor(this._posicion, this._recurso, this._stock_inicial,
      this._ratio_produccion) {
    this._stock = this._stock_inicial;
  }

  Punto get_posicion() {
    return this._posicion;
  }

  Recurso get_recurso() {
    return this._recurso;
  }

  int extrae(int cantidad) {
    cantidad = (cantidad * this._ratio_produccion)
        .toInt(); // Para penalizaciones y bonus

    // Los productores con cantidadMaxima = 0 son inagotables.
    if (this._stock_inicial == 0) {
      return cantidad;
    }
    if (cantidad > this._stock) {
      cantidad = this._stock;
      this._stock = 0;
    } else {
      /* if (this._recurso == ORO) {
        print('A: Cantidad B: ${cantidad} Cantidad maxima: ${this._stock}');
      } */
      this._stock -= cantidad;
    }
    return cantidad;
  }

  int getStock() {
    return this._stock;
  }

  int get_cantidad_maxima() {
    return this._stock_inicial;
  }

  int get_extraido() {
    int resultado = this._stock_inicial - this._stock;
    if (resultado < 0) {
      resultado = this._stock_inicial;
    }

    return resultado;
  }
}
