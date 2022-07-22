import './Productor.clase.dart';
import './Almacen.clase.dart';

class Extractor {
  Productor _productor;
  Almacen _almacen;
  int _cantidad;

  Extractor (this._productor, this._almacen, this._cantidad) {}

  Almacen get_almacen() {
    return this._almacen;
  }

  getCantidad( ) {
    int cantidad = this._cantidad;
    return this._productor.extrae(cantidad);
  }
}