import './Punto.clase.dart';
import './Imperio.clase.dart';
import './Dispatcher.clase.dart';
import './Recurso.clase.dart';

class Unidades {
  UnidadMilitar unidad;
  int cantidad;

  Unidades (this.unidad, this.cantidad);
}

class Ejercito {
  int id;
  String nombre;
  Punto _posicion;
  Localidad ciudad;
  Dispatcher disp;

  late List<Unidades> _unidades;

  Ejercito (this.id, this.nombre, this._posicion, this.ciudad, this.disp) {
    this._unidades = [];
  }

  List<Unidades> getTropas() { return this._unidades; }

  void addUnidades (UnidadMilitar tipo, int cantidad) {
    int indiceElemento = -1;
    int indice = 0;
    if (this._unidades != null) {
      this._unidades.forEach( (x) {
        if (x.unidad.getID() == tipo.getID()) {indiceElemento = indice; }
        indice++;
      });
    }
    
    if ( indiceElemento == -1) {
      Unidades nuevaUnidad = new Unidades(tipo, cantidad);
      this._unidades.add (nuevaUnidad);
    } else {
      this._unidades[indiceElemento].cantidad += cantidad;
    }
  }

  Punto getPosicion() { return this._posicion; }
}
