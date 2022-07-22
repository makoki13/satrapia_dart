import './Edificio.clase.dart';
import './Espia.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';

class Taberna extends Edificio {
  late List<Espia> espias;

  int id;
  String nombre;
  Capital _capital;
  Dispatcher _disp;

  Taberna(this.id, this.nombre, this._capital, this._disp)
      : super(id, nombre, TipoEdificio.TABERNA, _capital.getPosicion(), 0, 0) {
    this._capital.setTaberna(this);
    this.espias = [];
  }

  addEspia(Espia nuevoEspia) {
    this.espias.add(nuevoEspia);
  }

  List<Espia> getLista() {
    return this.espias;
  }

  Dispatcher get_dispatcher() {
    return this._disp;
  }
}
