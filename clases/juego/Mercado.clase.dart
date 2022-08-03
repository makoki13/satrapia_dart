import './Edificio.clase.dart';
import './Silo.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';

class Mercado extends Edificio {
  late List<Silo> silos;

  int id;
  String nombre;
  Capital _capital;
  Dispatcher _disp;

  Mercado(this.id, this.nombre, this._capital, this._disp)
      : super(id, nombre, TipoEdificio.MERCADO, _capital.getPosicion(), 0, 0) {
    this._capital.setMercado(this);
    this.silos = [];
  }

  addSilo(Silo nuevoSilo) {
    this.silos.add(nuevoSilo);
  }

  List<Silo> getLista() {
    return this.silos;
  }

  Dispatcher get_dispatcher() {
    return this._disp;
  }
}
