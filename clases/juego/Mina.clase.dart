import './Extractor.clase.dart';
import './Productor.clase.dart';
import './Almacen.clase.dart';
import './Edificio.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';
import './Recurso.clase.dart';
import './Transporte.clase.dart';
import './Punto.clase.dart';

class Mina extends Edificio {
  int _costeConstruccion;
  int _tiempoConstruccion;

  late Extractor mineros;
  late Productor filon;
  late Almacen _almacen;

  int id;
  String _nombre;
  late Capital capital;
  TipoEdificio _tipoEdificio;
  Recurso _recurso;
  late Almacen almacenDestino;
  Capital _capital;
  Dispatcher _disp;
  Punto _posicion;

  Mina(
      this.id,
      this._nombre,
      this._tipoEdificio,
      this._recurso,
      this._posicion,
      this._capital,
      this._disp,
      this._costeConstruccion,
      this._tiempoConstruccion)
      : super(id, _nombre, _tipoEdificio, _posicion, _costeConstruccion,
            _tiempoConstruccion) {
    this.filon =
        new Productor(new Punto(0, 0, -1), this._recurso, 20000, 20, 1);
    this._almacen = new Almacen(67, 'Filón de ' + this._recurso.getNombre(),
        this._recurso, _posicion, 10);
    const cantidadInicial = 1;
    this.mineros = new Extractor(this.filon, this._almacen, cantidadInicial);
    this._disp.addTareaRepetitiva(extrae, 1);
    this.setStatus('Sin envios actuales');

    this.almacenDestino = this._capital.getSilos().getAlmacenComida();
    if (this._recurso == MADERA)
      this.almacenDestino = this._capital.getSilos().getAlmacenMadera();
    if (this._recurso == PIEDRA)
      this.almacenDestino = this._capital.getSilos().getAlmacenPiedra();
    if (this._recurso == HIERRO)
      this.almacenDestino = this._capital.getSilos().getAlmacenHierro();
    if (this._recurso == ORO)
      this.almacenDestino = this._capital.getPalacio().getAlmacen();
  }

  int get_coste_construccion() {
    return this._costeConstruccion;
  }

  int get_tiempo_construccion() {
    return this._tiempoConstruccion;
  }

  TipoEdificio get_tipo_edificio() {
    return this._tipoEdificio;
  }

  String toString() {
    return this._nombre;
  }

  Almacen getAlmacen() {
    return this._almacen;
  }

  extrae() {
    int cantidad = this.mineros.getCantidad();
    this._almacen.addCantidad(cantidad);

    /* Si el almacen alcanza el tope enviar un transporte de recursos a palacio */
    if (this._almacen.getCantidad() >= this._almacen.getMaxCantidad()) {
      if (this.hayEnvioEnMarcha == false) {
        this.hayEnvioEnMarcha = true;
        this.enviaRecursosHaciaPalacio(almacenDestino);
      }
    }
  }

  enviaRecursosHaciaPalacio(almacenDestino) {
    int cantidad = this._almacen.restaCantidad(this._almacen.getCantidad());
    Transporte transporteDeRecurso = new Transporte(
        this._almacen, almacenDestino, this._recurso, cantidad, this);

    transporteDeRecurso.calculaViaje();
    this.setStatus('Enviando ' + this._recurso.getNombre() + '...');
    this._disp.addTareaRepetitiva(transporteDeRecurso.envia, 1);
  }

  num getCantidadAlmacenActual() {
    return this._almacen.getCantidad();
  }

  num getMaxAlmacen() {
    return this._almacen.getMaxCantidad();
  }

  String getStatus() {
    return this.status;
  }

  bool estaActiva() {
    return (this.filon.getStock() > 0);
  }
}

/* *************************************************************************************** */
/* CLASE MINA DE ORO */
class MinaDeOro extends Mina {
  static int costeConstruccion = 250;
  static int tiempoContruccion = 5;

  int id;
  String nombre;

  MinaDeOro(
      this.id, this.nombre, Punto posicion, Capital capital, Dispatcher disp)
      : super(id, nombre, TipoEdificio.MINA_DE_ORO, ORO, posicion, capital,
            disp, MinaDeOro.costeConstruccion, MinaDeOro.tiempoContruccion) {
    capital.addMinaDeOro(this);
  }

  num getOroActual() {
    return this._almacen.getCantidad();
  }

  bool estaActiva() {
    return (this.filon.getStock() > 0);
  }
}

/* *****************************************************************************************/
/* CLASE MINA DE HIERRO */
class MinaDeHierro extends Mina {
  static int costeConstruccion = 250;
  static int tiempoContruccion = 5;

  int id;
  String nombre;

  MinaDeHierro(
      this.id, this.nombre, Punto posicion, Capital capital, Dispatcher disp)
      : super(
            id,
            nombre,
            TipoEdificio.MINA_DE_HIERRO,
            HIERRO,
            posicion,
            capital,
            disp,
            MinaDeHierro.costeConstruccion,
            MinaDeHierro.tiempoContruccion) {
    capital.addMinaDeHierro(this);
  }

  num getHierroActual() {
    return this._almacen.getCantidad();
  }
}
