import './Edificio.clase.dart';
import './Parametros.clase.dart';
import './Extractor.clase.dart';
import './Productor.clase.dart';
import 'Silo.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';
import './Recurso.clase.dart';
import './Transporte.clase.dart';
import './Punto.clase.dart';

class Serreria extends Edificio {
  static int costeConstruccion = Parametros.Serreria_Construccion_Coste;
  static int tiempoContruccion = Parametros.Serreria_Construccion_Tiempo;
  int cantidadMaxima = Parametros.Serreria_Productor_CantidadMaxima;
  int maximoItems = Parametros.Serreria_Num_Total;

  late Extractor _lenyadores;
  late Productor _filon;
  late Silo _silo;

  int id;
  String _nombre;
  Punto _posicion;
  Capital _capital;
  Dispatcher _disp;

  Serreria(this.id, this._nombre, this._posicion, this._capital, this._disp)
      : super(id, _nombre, TipoEdificio.SERRERIA, _posicion,
            Serreria.costeConstruccion, Serreria.tiempoContruccion) {
    this._capital.addSerreria(this);
    this._filon = new Productor(new Punto(0, 0, -1), MADERA,
        this.cantidadMaxima, Parametros.Serreria_Productor_Ratio);
    this._silo = new Silo(67, 'Silo de madera', MADERA, this._posicion,
        Parametros.Serreria_Almacen_Capacidad);
    this._lenyadores = new Extractor(
        this._filon, this._silo, Parametros.Serreria_Cosecha_Tamanyo);

    this._disp.addTareaRepetitiva(extrae, Parametros.Serreria_Cosecha_Tamanyo);

    this.setStatus('Sin envios actuales');
  }

  String toString() {
    return this._nombre;
  }

  Silo getSilo() {
    return this._silo;
  }

  extrae() {
    int cantidad = this._lenyadores.getCantidad();
    this._silo.add_cantidad(cantidad);

    /* Si el almacen alcanza el tope enviar un transporte de comida a palacio */
    if (this._silo.get_cantidad() >= this._silo.get_max_cantidad()) {
      if (this.hayEnvioEnMarcha == false) {
        this.hayEnvioEnMarcha = true;
        this.enviaMaderaHaciaCiudad();
      }
    }
  }

  enviaMaderaHaciaCiudad() {
    int cantidad = this._silo.resta_cantidad(this._silo.get_cantidad());
    Transporte transporteDeMadera = new Transporte(
        this._posicion, this._capital.getAlmacen(), MADERA, cantidad, this);

    transporteDeMadera.calculaViaje();
    this.setStatus('Enviando madera...');
    this._disp.addTareaRepetitiva(
        transporteDeMadera.envia, Parametros.Transporte_Tiempo_Recalculo_Ruta);
  }

  num getMaderaActual() {
    return this._silo.get_cantidad();
  }

  num getMaxAlmacen() {
    return this._silo.get_max_cantidad();
  }

  String getStatus() {
    return this.status;
  }

  bool estaActiva() {
    return (this._filon.getStock() > Parametros.Filon_Vacio);
  }
}
