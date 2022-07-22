import './Edificio.clase.dart';
import './Parametros.clase.dart';
import './Extractor.clase.dart';
import './Productor.clase.dart';
import './Almacen.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';
import './Recurso.clase.dart';
import './Transporte.clase.dart';
import './Punto.clase.dart';

class Serreria extends Edificio {
  static int costeConstruccion = Parametros.Serreria_Construccion_Coste;
  static int tiempoContruccion = Parametros.Serreria_Construccion_Tiempo;
  int cantidadInicial = Parametros.Serreria_Productor_CantidadInicial;
  int cantidadMaxima = Parametros.Serreria_Productor_CantidadMaxima;
  int maximoItems = Parametros.Serreria_Num_Total;

  late Extractor _lenyadores;
  late Productor _filon;
  late Almacen _almacen;

  int id;
  String _nombre;
  Punto _posicion;
  Capital _capital;
  Dispatcher _disp;

  Serreria(this.id, this._nombre, this._posicion, this._capital, this._disp)
      : super(id, _nombre, TipoEdificio.SERRERIA, _posicion,
            Serreria.costeConstruccion, Serreria.tiempoContruccion) {
    this._capital.addSerreria(this);
    this._filon = new Productor(
        new Punto(0, 0, -1),
        MADERA,
        this.cantidadInicial,
        this.cantidadMaxima,
        Parametros.Serreria_Productor_Ratio);
    this._almacen = new Almacen(67, 'Silo de madera', MADERA, this._posicion,
        Parametros.Serreria_Almacen_Capacidad);
    this._lenyadores = new Extractor(
        this._filon, this._almacen, Parametros.Serreria_Cosecha_Tamanyo);

    this._disp.addTareaRepetitiva(extrae, Parametros.Serreria_Cosecha_Tamanyo);

    this.setStatus('Sin envios actuales');
  }

  String toString() {
    return this._nombre;
  }

  Almacen getAlmacen() {
    return this._almacen;
  }

  extrae() {
    int cantidad = this._lenyadores.getCantidad();
    this._almacen.addCantidad(cantidad);

    /* Si el almacen alcanza el tope enviar un transporte de comida a palacio */
    if (this._almacen.getCantidad() >= this._almacen.getMaxCantidad()) {
      if (this.hayEnvioEnMarcha == false) {
        this.hayEnvioEnMarcha = true;
        this.enviaMaderaHaciaCiudad();
      }
    }
  }

  enviaMaderaHaciaCiudad() {
    int cantidad = this._almacen.restaCantidad(this._almacen.getCantidad());
    Transporte transporteDeMadera = new Transporte(this._almacen,
        this._capital.getSilos().getAlmacenMadera(), MADERA, cantidad, this);

    transporteDeMadera.calculaViaje();
    this.setStatus('Enviando madera...');
    this._disp.addTareaRepetitiva(
        transporteDeMadera.envia, Parametros.Transporte_Tiempo_Recalculo_Ruta);
  }

  num getMaderaActual() {
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
