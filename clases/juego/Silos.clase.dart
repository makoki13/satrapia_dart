import './Edificio.clase.dart';
import './Almacen.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';
import './Recurso.clase.dart';

class Silos extends Edificio {
  late List<Almacen> almacenes;

  int _id;
  String _nombre;
  Capital _capital;
  Dispatcher _disp;

  Silos(this._id, this._nombre, this._capital, this._disp)
      : super(_id, _nombre, TipoEdificio.SILOS, _capital.getPosicion(), 0, 0) {
    this._capital.setSilos(this);
    this.almacenes = [];
  }

  int get_id() {
    return this._id;
  }

  String get_nombre() {
    return this._nombre;
  }

  Dispatcher get_dispatcher() {
    return this._disp;
  }

  addAlmacen(Almacen nuevoAlmacen) {
    this.almacenes.add(nuevoAlmacen);
  }

  List<Almacen> getLista() {
    return this.almacenes;
  }

  Almacen getAlmacenComida() {
    dynamic a;
    this.almacenes.forEach((almacen) {
      //print("iteracion almacen comida: "+almacen.toString());
      if (almacen.get_tipo_recurso().getID() == COMIDA.getID()) {
        a = almacen;
      }
    });
    return a;
  }

  Almacen getAlmacenMadera() {
    dynamic al = null;
    this.almacenes.forEach((almacen) {
      if (almacen.get_tipo_recurso() == MADERA) {
        al = almacen;
        return;
      }
    });
    return al;
  }

  Almacen getAlmacenPiedra() {
    dynamic al = null;
    this.almacenes.forEach((almacen) {
      if (almacen.get_tipo_recurso() == PIEDRA) {
        al = almacen;
        return;
      }
    });
    return al;
  }

  Almacen getAlmacenHierro() {
    dynamic al = null;
    this.almacenes.forEach((almacen) {
      if (almacen.get_tipo_recurso() == HIERRO) {
        al = almacen;
        return;
      }
    });
    return al;
  }
}
