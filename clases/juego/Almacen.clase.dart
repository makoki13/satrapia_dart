import './Edificio.clase.dart';
import 'Silo.clase.dart';
import './Dispatcher.clase.dart';
import './Recurso.clase.dart';
import './Punto.clase.dart';

class Almacen extends Edificio {
  late List<Silo> silos;

  int _id;
  String _nombre;
  Dispatcher _disp;
  Punto _posicion;

  Almacen(this._id, this._nombre, this._posicion, this._disp)
      : super(_id, _nombre, TipoEdificio.ALMACEN, _posicion, 0, 0) {
    this.silos = [];
  }

  int get_id() {
    return this._id;
  }

  String get_nombre() {
    return this._nombre;
  }

  Punto get_posicion() {
    return this._posicion;
  }

  Dispatcher get_dispatcher() {
    return this._disp;
  }

  addSilo(Silo nuevoSilo) {
    this.silos.add(nuevoSilo);
  }

  List<Silo> getLista() {
    return this.silos;
  }

  Silo getSiloComida() {
    late Silo a;
    this.silos.forEach((silo) {
      if (silo.get_tipo_recurso().getID() == COMIDA.getID()) {
        a = silo;
      }
    });
    return a;
  }

  Silo getSiloMadera() {
    late Silo a;
    this.silos.forEach((silo) {
      if (silo.get_tipo_recurso() == MADERA) {
        a = silo;
        return;
      }
    });
    return a;
  }

  Silo getSiloPiedra() {
    late Silo a;
    this.silos.forEach((silo) {
      if (silo.get_tipo_recurso() == PIEDRA) {
        a = silo;
        return;
      }
    });
    return a;
  }

  Silo getSiloHierro() {
    late Silo a;
    this.silos.forEach((silo) {
      if (silo.get_tipo_recurso() == HIERRO) {
        a = silo;
        return;
      }
    });
    return a;
  }

  Silo getSiloOro() {
    late Silo a;
    this.silos.forEach((silo) {
      if (silo.get_tipo_recurso() == ORO) {
        a = silo;
        return;
      }
    });
    return a;
  }

  void add_cantidad(Recurso recurso, int cantidad) {
    late Silo silo;
    switch (recurso.getNombre()) {
      case 'COMIDA':
        silo = this.getSiloComida();
        break;
      case 'MADERA':
        silo = this.getSiloMadera();
        break;
      case 'PIEDRA':
        silo = this.getSiloPiedra();
        break;
      case 'HIERRO':
        silo = this.getSiloHierro();
        break;
      case 'ORO':
        silo = this.getSiloOro();
        break;
    }
    silo.add_cantidad(cantidad);
  }

  /* Map<String, dynamic> toJson() => {
        'comida': this.getSiloComida().get_cantidad(),
        'madera': this.getSiloMadera().get_cantidad(),
        'piedra': this.getSiloPiedra().get_cantidad(),
        'hierro': this.getSiloHierro().get_cantidad(),
        'oro'   : this.getSiloOro().get_cantidad(),
      }; */

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comida'] = this.getSiloComida().get_cantidad();
    data['madera'] = this.getSiloMadera().get_cantidad();
    data['piedra'] = this.getSiloPiedra().get_cantidad();
    data['hierro'] = this.getSiloHierro().get_cantidad();
    data['oro'] = this.getSiloOro().get_cantidad();
    return data;
  }
}
