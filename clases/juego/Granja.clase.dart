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
  static num costeConstruccion = Parametros.Granja_Construccion_Coste;
  static num tiempoContruccion = Parametros.Granja_Construccion_Tiempo;
  static num cantidadInicial = Parametros.Granja_Productor_CantidadInicial;
  static num cantidadMaxima = Parametros.Granja_Productor_CantidadMaxima;
  static num ratio = Parametros.Granja_Productor_Ratio;
  static num capacidadAlmacen = Parametros.Granja_Almacen_Capacidad;
  static num tamanyoCosecha = Parametros.Granja_Cosecha_Tamanyo;
  static num cosechaFrecuencia = Parametros.Granja_Cosecha_Frecuencia;
  static num maximoItems = Parametros.Granja_Num_Total;

  Extractor _granjeros;
  Productor _filon;
  Almacen _almacen;

  num id;
  String _nombre;
  Punto _posicion;
  Capital _capital;
  Dispatcher _disp;

  Granja (this.id, this._nombre, this._posicion, this._capital, this._disp) :  super (id, _nombre, TipoEdificio.GRANJA, _posicion, Granja.costeConstruccion, Granja.tiempoContruccion) {
    this._capital.addGranja(this);

    this._filon = new Productor ( null, COMIDA, Parametros.Granja_Productor_CantidadInicial,
    Parametros.Granja_Productor_CantidadMaxima, Parametros.Granja_Productor_Ratio);
    this._almacen = new Almacen ( 67, 'Silo de comida', COMIDA, this._posicion, Parametros.Granja_Almacen_Capacidad);
    this._granjeros = new Extractor (this._filon, this._almacen, Parametros.Granja_Cosecha_Tamanyo);

    this._disp.addTareaRepetitiva(this, 'extrae', Granja.cosechaFrecuencia);

    this.setStatus ('Sin envios actuales');
  }

  myCallBack(String funcion, [List<dynamic>parametros]) {
    switch(funcion) {
      case 'extrae': this.extrae(); return;
      default:
    }
  }

  extrae() {
    num cantidad = this._granjeros.getCantidad();

    this._almacen.addCantidad (cantidad);

    print("En almacen hay ${this._almacen.getCantidad()}");

    /* Si el almacen alcanza el tope enviar un transporte de comida a palacio */
    if (this._almacen.getCantidad() >= this._almacen.getMaxCantidad()) {
      if (this.hayEnvioEnMarcha == false) {
        this.hayEnvioEnMarcha = true;
        this.enviaComidaHaciaCiudad();
      }
    }
  }

  enviaComidaHaciaCiudad() {
    num cantidad = this._almacen.restaCantidad(this._almacen.getCantidad());
    Almacen almacenDestino = this._capital.getSilos().getAlmacenComida();
    print('Transporte destino: ${almacenDestino.getPosicion().getX()} , ${almacenDestino.getPosicion().getY()} ');
    print('Transporte actual: ${this._almacen.getPosicion().getX()} , ${this._almacen.getPosicion().getY()} ');
    Transporte transporteDeComida = new Transporte (this._almacen, this._capital.getSilos().getAlmacenComida(), COMIDA, cantidad, this );

    transporteDeComida.calculaViaje();
    this.setStatus ('Enviando comida...');
    this._disp.addTareaRepetitiva(transporteDeComida, 'envia', Parametros.Transporte_Tiempo_Recalculo_Ruta);
  }

  num getComidaActual() { return this._almacen.getCantidad(); }
  num getMaxAlmacen() { return this._almacen.getMaxCantidad(); }

  String getStatus() { return this.status; }
  //public setStatus( mensaje: string ) { super.setStatus(mensaje); }

  bool estaActiva() { return (this._filon.getStock() > Parametros.Filon_Vacio); }
}