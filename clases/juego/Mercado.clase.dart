import './Edificio.clase.dart';
import './Almacen.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';

class Mercado extends Edificio {
  late List<Almacen> almacenes;

  int id;
  String nombre;
  Capital _capital;
  Dispatcher _disp;

  Mercado(this.id, this.nombre, this._capital, this._disp)
      : super(id, nombre, TipoEdificio.MERCADO, _capital.getPosicion(), 0, 0) {
    this._capital.setMercado(this);
    this.almacenes = [];
  }

  addAlmacen(Almacen nuevoAlmacen) {
    this.almacenes.add(nuevoAlmacen);
  }

  List<Almacen> getLista() {
    return this.almacenes;
  }

  Dispatcher get_dispatcher() {
    return this._disp;
  }
}
