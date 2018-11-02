import './Edificio.clase.dart';
import './Parametros.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';
import './Extractor.clase.dart';
import './Productor.clase.dart';
import './Almacen.clase.dart';
import './Recurso.clase.dart';
import './Transporte.clase.dart';
import './Punto.clase.dart';

class Cantera extends Edificio {
  num costeConstruccion = Parametros.Cantera_Construccion_Coste;
  num tiempoConstruccion = Parametros.Cantera_Construccion_Tiempo;
  num cantidadInicial = Parametros.Cantera_Productor_CantidadInicial;
  num cantidadMaxima = Parametros.Cantera_Productor_CantidadMaxima;

  num _id;
  String _nombre;
  Punto _posicion;
  Capital _capital;
  Dispatcher _disp;
  Extractor _canteros;
  Productor _filon;
  Almacen _almacen;

  Productor filon;
  Almacen almacen;
  Extractor canteros;

  Cantera (this._id, this._nombre, this._posicion, this._capital, this._disp) :  super (_id, _nombre, TipoEdificio.CANTERA_DE_PIEDRA, _posicion,
      Parametros.Cantera_Construccion_Coste, Parametros.Cantera_Construccion_Tiempo) {

    this._capital.addCantera(this);

    this.filon = new Productor ( null, PIEDRA, this.cantidadInicial, this.cantidadMaxima, Parametros.Cantera_Productor_Ratio);
    this.almacen = new Almacen ( 68, 'Cantera de piedra', PIEDRA, this._posicion, Parametros.Cantera_Almacen_Capacidad);
    this.canteros = new Extractor (this.filon, this.almacen, Parametros.Cantera_Cosecha_Tamanyo);

    this._disp.addTareaRepetitiva(extrae, Parametros.Cantera_Cosecha_Tamanyo);

    this.setStatus ('Sin envios actuales');
  }

  String toString() { return this._nombre;}

  extrae() {
    int cantidad = this.canteros.getCantidad();
    this.almacen.addCantidad (cantidad);

    /* Si el almacen alcanza el tope enviar un transporte de piedra a palacio */
    if (this.almacen.getCantidad() >= this.almacen.getMaxCantidad()) {      
      if (this.hayEnvioEnMarcha == false) {        
        this.hayEnvioEnMarcha = true;
        this.enviaPiedraHaciaCiudad();
      }
    }
  }

  enviaPiedraHaciaCiudad() {
    int cantidad = this.almacen.restaCantidad(this.almacen.getCantidad());
    Transporte transporteDePiedra = new Transporte (this.almacen, this._capital.getSilos().getAlmacenPiedra(), PIEDRA, cantidad, this );

    transporteDePiedra.calculaViaje();
    this.setStatus ('Enviando piedra...');
    this._disp.addTareaRepetitiva(transporteDePiedra.envia, Parametros.Transporte_Tiempo_Recalculo_Ruta);
  }

  num getPiedraActual() { return this.almacen.getCantidad(); }
  num getMaxAlmacen() { return this.almacen.getMaxCantidad(); }

  String getStatus() { return this.status; }
  setStatus( String mensaje ) { super.setStatus(mensaje); }

  bool estaActiva() { return (this.filon.getStock() > Parametros.Filon_Vacio); }
}
