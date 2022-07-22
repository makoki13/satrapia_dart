import './Edificio.clase.dart';
import 'Imperio.clase.dart';

enum TipoTerreno { Sin_Definir, Prado, Bosque, Mar, Agua_Poco_Profunda }

class Region {
  late int _id;

  Region(this._id);

  int get_id() {
    return this._id;
  }
}

class Punto {
  late TipoTerreno _tipoDeTerreno;
  late Region _region; // Geografia fisica
  late Provincia _provincia; // Geografia politica
  late TipoEdificio _edificio;

  static sonIguales(Punto p, Punto q) {
    return ((p.getX() == q.getX()) && (p.getY() == q.getY()));
  }

  num _x;
  num _y;
  num _z;

  Punto(this._x, this._y, this._z) {
    this._edificio = TipoEdificio.OTROS;
  }

  set_region(Region region) {
    this._region = region;
  }

  get_region() {
    return this._region;
  }

  set_provincia(Provincia provincia) {
    this._provincia = provincia;
  }

  get_provincia() {
    return this._provincia;
  }

  setAltura(num z) {
    this._z = z;
  }

  setEdificio(TipoEdificio e) {
    this._edificio = e;
  }

  num getX() {
    return this._x;
  }

  num getY() {
    return this._y;
  }

  num getZ() {
    return this._z;
  }

  TipoEdificio getEdificio() {
    return this._edificio;
  }

  TipoTerreno getTerreno() {
    return this._tipoDeTerreno;
  }
}
