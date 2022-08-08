import './Edificio.clase.dart';
import './Extractor.clase.dart';
import './Productor.clase.dart';
import './Silo.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';
import './Recurso.clase.dart';
import './Parametros.clase.dart';
import './Punto.clase.dart';

class Palacio extends Edificio {
  late Extractor _recaudador;
  late Extractor _crecimientoDemografico;

  late Productor _impuestos;
  late Productor _alojamientos;

  late Silo tesoro;
  late Silo poblacion;

  int _id;
  String _nombre;
  Capital _capital;
  Dispatcher _disp;

  Palacio(this._id, this._nombre, this._capital, this._disp)
      : super(
            _id, _nombre, TipoEdificio.PALACIO, _capital.getPosicion(), 0, 0) {
    this._capital.setPalacio(this);

    //esto debería ser incremento
    int cantidadInicial = 2;
    this._impuestos =
        new Productor(new Punto(0, 0, -1), ORO, Parametros.MAX_ENTERO, 1);
    this.tesoro = new Silo(66, 'Deposito de oro', ORO, _capital.getPosicion(),
        Parametros.MAX_ENTERO);

    this.tesoro.add_cantidad(Parametros.oroInicial);
    this._recaudador =
        new Extractor(this._impuestos, this.tesoro, cantidadInicial);
    // no parece que funcione lo de los segundos entre tarea y tarea
    this._disp.addTareaRepetitiva(recaudaImpuestos, 1);

    //esto debería ser incremento
    cantidadInicial = 1;
    const cantidadMaxima = 50000;
    this._alojamientos =
        new Productor(new Punto(0, 0, -1), POBLACION, cantidadMaxima, 1);
    this.poblacion = new Silo(
        67, 'Población', POBLACION, _capital.getPosicion(), cantidadMaxima);
    this.poblacion.add_cantidad(Parametros.poblacion_inicial);
    this._crecimientoDemografico =
        new Extractor(this._alojamientos, this.poblacion, cantidadInicial);
    // no parece que funcione lo de los segundos entre tarea y tarea
    this._disp.addTareaRepetitiva(realizaCenso, 10);
  }

  Map<String, dynamic> toJson() => {
        'id': _id,
        'nombre': _nombre,
        'oro': this.tesoro.get_cantidad(),
        'poblacion': this.poblacion.get_cantidad(),
      };

  int get_id() {
    return this._id;
  }

  String toString() {
    return this._nombre;
  }

  recaudaImpuestos() {
    int cantidad = this._recaudador.getCantidad();
    this.tesoro.add_cantidad(cantidad);
  }

  realizaCenso() {
    int cantidad = this._crecimientoDemografico.getCantidad();
    this.poblacion.add_cantidad(cantidad);
  }

  int getOroActual() {
    return this.tesoro.get_cantidad();
  }

  int getPoblacionActual() {
    return this.poblacion.get_cantidad();
  }

  Silo getTesoro() {
    return this.tesoro;
  }

  int gastaOro(int cantidad) {
    int cantidadActual = this.tesoro.get_cantidad();
    if (cantidadActual < cantidad) {
      cantidad = cantidadActual;
    }
    this.tesoro.resta_cantidad(cantidad);
    return cantidad;
  }

  entraOro(int cantidad) {
    this.tesoro.add_cantidad(cantidad);
  }
}
