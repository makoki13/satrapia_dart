import './Extractor.clase.dart';
import './Productor.clase.dart';
import './Silo.clase.dart';
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
  late Silo _silo;

  int id;
  String _nombre;
  late Capital capital;
  TipoEdificio _tipoEdificio;
  Recurso _recurso;
  late dynamic almacenDestino;
  Capital _capital;
  Dispatcher _disp;
  Punto _posicion;

  Mina(
      this.id,
      this._nombre,
      this._tipoEdificio,
      this._recurso,
      this._posicion,
      stock_inicial,
      this._capital,
      this._disp,
      this._costeConstruccion,
      this._tiempoConstruccion)
      : super(id, _nombre, _tipoEdificio, _posicion, _costeConstruccion,
            _tiempoConstruccion) {
    // ignore: todo
    //TODO -> hay que sacar los valores 20,000 y 200 de los parámetros iniciales
    // 200 podría ser un valro aleatorio que determina la riquza de la
    this.filon =
        new Productor(new Punto(0, 0, -1), this._recurso, stock_inicial, 1);
    this._silo = new Silo(67, 'Filón de ' + this._recurso.getNombre(),
        this._recurso, _posicion, 10);
    const cantidadInicial = 1;
    this.mineros = new Extractor(this.filon, this._silo, cantidadInicial);
    this._disp.addTareaRepetitiva(extrae, 1);
    this.setStatus('Sin envios actuales');

    this.almacenDestino = this._capital.getAlmacen();
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

  Silo getSilo() {
    return this._silo;
  }

  extrae() {
    int cantidad = this.mineros.getCantidad();
    this._silo.add_cantidad(cantidad);

    /* Si el almacen alcanza el tope enviar un transporte de recursos a palacio */
    if (this._silo.get_cantidad() >= this._silo.get_max_cantidad()) {
      if (this.hayEnvioEnMarcha == false) {
        this.hayEnvioEnMarcha = true;
        this.enviaRecursosHaciaPalacio(almacenDestino);
      }
    }
  }

  enviaRecursosHaciaPalacio(almacenDestino) {
    int cantidad = this._silo.resta_cantidad(this._silo.get_cantidad());
    Transporte transporteDeRecurso = new Transporte(
        this._posicion, almacenDestino, this._recurso, cantidad, this);

    transporteDeRecurso.calculaViaje();
    this.setStatus('Enviando ' + this._recurso.getNombre() + '...');
    this._disp.addTareaRepetitiva(transporteDeRecurso.envia, 1);
  }

  num getCantidadSiloActual() {
    return this._silo.get_cantidad();
  }

  num getMaxSilo() {
    return this._silo.get_max_cantidad();
  }

  String getStatus() {
    return this.status;
  }

  bool estaActiva() {
    return (this.filon.getStock() > 0);
  }

  int get_cantidad_filon() {
    return this.filon.get_cantidad_maxima();
  }

  int get_stock_filon() {
    return this.filon.getStock();
  }
}

/* *************************************************************************************** */
/* CLASE MINA DE ORO */
class MinaDeOro extends Mina {
  static int costeConstruccion = 250;
  static int tiempoContruccion = 5;
  static int cantidad_maxima = 20000;

  int id;
  String nombre;

  MinaDeOro(
      this.id, this.nombre, Punto posicion, Capital capital, Dispatcher disp)
      : super(
            id,
            nombre,
            TipoEdificio.MINA_DE_ORO,
            ORO,
            posicion,
            cantidad_maxima,
            capital,
            disp,
            MinaDeOro.costeConstruccion,
            MinaDeOro.tiempoContruccion) {
    capital.addMinaDeOro(this);
  }

  num getOroActual() {
    return this._silo.get_cantidad();
  }

  bool estaActiva() {
    return (this.filon.getStock() > 0);
  }

  Map<String, dynamic> toJson() => {'id': id, 'nombre': nombre};
}

/* *****************************************************************************************/
/* CLASE MINA DE HIERRO */
class MinaDeHierro extends Mina {
  static int costeConstruccion = 250;
  static int tiempoContruccion = 5;
  //Pasar a clase parametros
  static int cantidad_maxima = 20000;

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
            cantidad_maxima,
            capital,
            disp,
            MinaDeHierro.costeConstruccion,
            MinaDeHierro.tiempoContruccion) {
    capital.addMinaDeHierro(this);
  }

  num getHierroActual() {
    return this._silo.get_cantidad();
  }

  Map<String, dynamic> toJson() => {'id': id, 'nombre': nombre};
}
