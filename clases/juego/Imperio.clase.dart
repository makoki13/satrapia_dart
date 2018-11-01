import './Jugador.clase.dart';
import './Almacen.clase.dart';
import './Punto.clase.dart';
import './Productor.clase.dart';

class Imperio {
  num _id;
  String _nombre;
  Jugador _lider;
  bool _esTribu;
  Imperio (this._id, this._nombre, this._lider, this._esTribu) {}

  String getNombre() { return this._nombre; }
}

class Provincia extends Imperio {
  num _id;
  String _nombre;
  Jugador _lider;
  bool _esTribu;
  bool _esSatrapia;

  Provincia (this._id, this._nombre, this._lider, this._esTribu, this._esSatrapia) : super (_id, _nombre, _lider, _esTribu) {}
}

class Localidad {
  Productor _demografia;
  Almacen _poblacion;
  num _id;
  String _nombre;
  bool _esCapital;
  Provincia _provincia;
  num _numeroDeHabitantes;
  Punto _posicion;

  Localidad (this._id, this._nombre, this._esCapital, this._provincia, this._numeroDeHabitantes, this._posicion) {}

  Punto getPosicion() { return this._posicion; }
  String getNombre() { return this._nombre; }
}
