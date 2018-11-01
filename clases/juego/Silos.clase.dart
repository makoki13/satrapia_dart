import './Edificio.clase.dart';
import './Almacen.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';
import './Recurso.clase.dart';

class Silos extends Edificio {
  List<Almacen> almacenes;

  num _id;
  String _nombre;
  Capital _capital;
  Dispatcher _disp;

  Silos (this._id, this._nombre, this._capital, this._disp) :  super (_id, _nombre, TipoEdificio.SILOS, _capital.getPosicion(), 0, 0) {
    this._capital.setSilos(this);
    this.almacenes = new List<Almacen>();
  }

  addAlmacen ( Almacen nuevoAlmacen) {
    this.almacenes.add ( nuevoAlmacen );
  }

  List<Almacen> getLista() {return this.almacenes;}

  Almacen getAlmacenComida() {
    Almacen a = null;
    this.almacenes.forEach( (almacen) {
        //print("iteracion almacen comida: "+almacen.toString());
        if (almacen.getTipoRecurso().id == COMIDA.id) {
          a = almacen;
        }
    });
    return a;
  }

  Almacen getAlmacenMadera() {
    Almacen al = null;
    this.almacenes.forEach( (almacen) {
      if (almacen.getTipoRecurso() == MADERA) { al = almacen; return; }
    });
    return al;
  }

  Almacen getAlmacenPiedra() {
    Almacen al = null;
    this.almacenes.forEach( (almacen) {
      if (almacen.getTipoRecurso() == PIEDRA) { al = almacen; return; }
    });
    return al;
  }

  Almacen getAlmacenHierro() {
    Almacen al = null;
    this.almacenes.forEach( (almacen) {
      if (almacen.getTipoRecurso() == HIERRO) { al = almacen; return; }
    });
    return al;
  }
}