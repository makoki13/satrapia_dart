import './Punto.clase.dart';
import './Recurso.clase.dart';

class Almacen {
  late int _cantidad;
  int _id;
  String _nombre;
  Recurso _tipo;
  Punto _posicion;
  int _max_cantidad;

  Almacen(
      this._id, this._nombre, this._tipo, this._posicion, this._max_cantidad) {
    this._cantidad = 0;
  }

  int get_id() {
    return this._id;
  }

  String get_nombre() {
    return this._nombre;
  }

  add_cantidad(int cantidad) {
    if (this._cantidad + cantidad > this._max_cantidad)
      this._cantidad = this._max_cantidad;
    else
      this._cantidad = this._cantidad + cantidad;
  }

  resta_cantidad(int cantidad) {
    if (cantidad > this._cantidad) {
      cantidad = this._cantidad;
      this._cantidad = 0;
    } else {
      this._cantidad -= cantidad;
    }
    return cantidad;
  }

  Recurso get_tipo_recurso() {
    return this._tipo;
  }

  int get_cantidad() {
    return this._cantidad;
  }

  Punto get_posicion() {
    return this._posicion;
  }

  int get_max_cantidad() {
    return this._max_cantidad;
  }
}
