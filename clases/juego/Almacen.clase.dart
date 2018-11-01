import './Punto.clase.dart';
import './Recurso.clase.dart';

class Almacen {
  num _cantidad;
  num _id;
  String _nombre;
  Recurso _tipo;
  Punto _posicion;
  num _maxCantidad;

  Almacen (this._id, this._nombre, this._tipo, this._posicion, this._maxCantidad) {
    this._cantidad = 0;
  }

  addCantidad (num cantidad) {
    this._cantidad = this._cantidad + cantidad;
  }

  restaCantidad ( num cantidad) {
    if (cantidad > this._cantidad) {
      cantidad = this._cantidad;
      this._cantidad = 0;
    } else {
      this._cantidad -= cantidad;
    }
    return cantidad;
  }

  Recurso getTipoRecurso() { return this._tipo; }

  num getCantidad () { return this._cantidad; }

  Punto getPosicion() { return this._posicion; }

  num getMaxCantidad() { return this._maxCantidad; }
}