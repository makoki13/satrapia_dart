import './Edificio.clase.dart';
import './Extractor.clase.dart';
import './Productor.clase.dart';
import './Almacen.clase.dart';
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

  late Almacen almacen;
  late Almacen poblacion;

  int _id;
  String _nombre;
  Capital _capital;
  Dispatcher _disp;

  Palacio(this._id, this._nombre, this._capital, this._disp)
      : super(
            _id, _nombre, TipoEdificio.PALACIO, _capital.getPosicion(), 0, 0) {
    this._capital.setPalacio(this);

    int cantidadInicial = 2;
    this._impuestos = new Productor(new Punto(0,0,-1), ORO, 10, Parametros.MAX_ENTERO, 1);
    this.almacen = new Almacen(66, 'Deposito de oro', ORO,
        _capital.getPosicion(), Parametros.MAX_ENTERO);

    this.almacen.addCantidad(Parametros.oroInicial);
    this._recaudador =
        new Extractor(this._impuestos, this.almacen, cantidadInicial);
    this._disp.addTareaRepetitiva(recaudaImpuestos, 1);

    cantidadInicial = 50;
    const cantidadMaxima = 1000;
    this._alojamientos =
        new Productor(new Punto(0,0,-1), POBLACION, cantidadInicial, cantidadMaxima, 1);
    this.poblacion = new Almacen(
        67, 'Población', POBLACION, _capital.getPosicion(), cantidadMaxima);
    this._crecimientoDemografico =
        new Extractor(this._alojamientos, this.poblacion, cantidadInicial);
    this._disp.addTareaRepetitiva(realizaCenso, 1);
  }

  int get_id() {
    return this._id;
  }

  String toString() {
    return this._nombre;
  }

  recaudaImpuestos() {
    int cantidad = this._recaudador.getCantidad();
    this.almacen.addCantidad(cantidad);
  }

  realizaCenso() {
    int cantidad = this._crecimientoDemografico.getCantidad();
    this.poblacion.addCantidad(cantidad);
  }

  int getOroActual() {
    return this.almacen.getCantidad();
  }

  int getPoblacionActual() {
    return this.poblacion.getCantidad();
  }

  Almacen getAlmacen() {
    return this.almacen;
  }

  int gastaOro(int cantidad) {
    int cantidadActual = this.almacen.getCantidad();
    if (cantidadActual < cantidad) {
      cantidad = cantidadActual;
    }
    this.almacen.restaCantidad(cantidad);
    return cantidad;
  }

  entraOro(int cantidad) {
    this.almacen.addCantidad(cantidad);
  }
}
