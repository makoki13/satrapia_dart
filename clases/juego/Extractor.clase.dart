import './Productor.clase.dart';
import 'Silo.clase.dart';

class Extractor {
  Productor _productor;
  Silo _silo;
  int _cantidad;

  Extractor(this._productor, this._silo, this._cantidad) {}

  Silo get_silo() {
    return this._silo;
  }

  getCantidad() {
    int cantidad = this._cantidad;
    return this._productor.extrae(cantidad);
  }
}
