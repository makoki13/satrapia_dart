import './Edificio.clase.dart';
import './Parametros.clase.dart';
import './Extractor.clase.dart';
import './Productor.clase.dart';
import './Almacen.clase.dart';
import './Recurso.clase.dart';
import './Transporte.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';
import './Punto.clase.dart';

class Granja extends Edificio {
  static int costeConstruccion = Parametros.Granja_Construccion_Coste;
  static int tiempoContruccion = Parametros.Granja_Construccion_Tiempo;
  static int cantidadInicial = Parametros.Granja_Productor_CantidadInicial;
  static int cantidadMaxima = Parametros.Granja_Productor_CantidadMaxima;
  static double ratio = Parametros.Granja_Productor_Ratio;
  static int capacidadAlmacen = Parametros.Granja_Almacen_Capacidad;
  static int tamanyoCosecha = Parametros.Granja_Cosecha_Tamanyo;
  static int cosechaFrecuencia = Parametros.Granja_Cosecha_Frecuencia;
  static int maximoItems = Parametros.Granja_Num_Total;

  late Extractor _granjeros;
  late Productor _filon;
  late Almacen _almacen;

  int id;
  String _nombre;
  Punto _posicion;
  Capital _capital;
  Dispatcher _disp;

  Granja(this.id, this._nombre, this._posicion, this._capital, this._disp)
      : super(id, _nombre, TipoEdificio.GRANJA, _posicion,
            Granja.costeConstruccion, Granja.tiempoContruccion) {
    this._capital.addGranja(this);

    this._filon = new Productor(
        new Punto(0, 0, -1),
        COMIDA,
        Parametros.Granja_Productor_CantidadInicial,
        Parametros.Granja_Productor_CantidadMaxima,
        Parametros.Granja_Productor_Ratio);
    this._almacen = new Almacen(67, 'Silo de comida', COMIDA, this._posicion,
        Parametros.Granja_Almacen_Capacidad);
    this._granjeros = new Extractor(
        this._filon, this._almacen, Parametros.Granja_Cosecha_Tamanyo);

    this._disp.addTareaRepetitiva(extrae, Granja.cosechaFrecuencia);

    this.setStatus('Sin envios actuales');
  }

  String toString() {
    return this._nombre;
  }

  Almacen getAlmacen() {
    return this._almacen;
  }

  extrae() {
    int cantidad = this._granjeros.getCantidad();

    this._almacen.addCantidad(cantidad);

    /* Si el almacen alcanza el tope enviar un transporte de comida a palacio */
    if (this._almacen.getCantidad() >= this._almacen.getMaxCantidad()) {
      if (this.hayEnvioEnMarcha == false) {
        this.hayEnvioEnMarcha = true;
        this.enviaComidaHaciaCiudad();
      }
    }
  }

  enviaComidaHaciaCiudad() {
    int cantidad = this._almacen.restaCantidad(this._almacen.getCantidad());
    Transporte transporteDeComida = new Transporte(this._almacen,
        this._capital.getSilos().getAlmacenComida(), COMIDA, cantidad, this);

    transporteDeComida.calculaViaje();
    this.setStatus('Enviando comida...');
    this._disp.addTareaRepetitiva(
        transporteDeComida.envia, Parametros.Transporte_Tiempo_Recalculo_Ruta);
  }

  num getComidaActual() {
    return this._almacen.getCantidad();
  }

  num getMaxAlmacen() {
    return this._almacen.getMaxCantidad();
  }

  String getStatus() {
    return this.status;
  }

  bool estaActiva() {
    return (this._filon.getStock() > Parametros.Filon_Vacio);
  }
}
