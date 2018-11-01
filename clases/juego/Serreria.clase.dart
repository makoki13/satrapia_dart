import './Edificio.clase.dart';
import './Parametros.clase.dart';
import './Extractor.clase.dart';
import './Productor.clase.dart';
import './Almacen.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';
import './Recurso.clase.dart';
import './Transporte.clase.dart';

class Serreria extends Edificio {
  num costeConstruccion = Parametros.Serreria_Construccion_Coste;
  num tiempoContruccion = Parametros.Serreria_Construccion_Tiempo;
  num cantidadInicial = Parametros.Serreria_Productor_CantidadInicial;
  num cantidadMaxima = Parametros.Serreria_Productor_CantidadMaxima;
  num maximoItems = Parametros.Serreria_Num_Total;

  Extractor _lenyadores;
  Productor _filon;
  Almacen _almacen;

  num id;
  String nombre;
  Capital _capital;
  Dispatcher _disp;

  Serreria (this.id, this.nombre, this._capital, this._disp, this.costeConstruccion, this.tiempoContruccion) :
        super (id, nombre, TipoEdificio.SERRERIA, _capital.getPosicion(), costeConstruccion, tiempoContruccion) {
    this._capital.addSerreria(this);
    this._filon = new Productor ( null, MADERA, this.cantidadInicial, this.cantidadMaxima, Parametros.Serreria_Productor_Ratio);
    this._almacen = new Almacen ( 67, 'Silo de madera', MADERA, this._capital.getPosicion(), Parametros.Serreria_Almacen_Capacidad);
    const cantidadInicial = 1;
    this._lenyadores = new Extractor (this._filon, this._almacen, Parametros.Serreria_Cosecha_Tamanyo);

    this._disp.addTareaRepetitiva(this, 'extrae', Parametros.Serreria_Cosecha_Tamanyo);

    this.setStatus ('Sin envios actuales');
  }

  myCallBack(String funcion, [List<dynamic>parametros]) {
    dynamic parametro = parametros[0];
    print("Funcion $funcion : Param1: $parametro");
    switch(funcion) {
      case 'extrae': this.extrae(); return;
      default:
    }
  }

  extrae() {
    num cantidad = this._lenyadores.getCantidad();
    this._almacen.addCantidad (cantidad);

    /* Si el almacen alcanza el tope enviar un transporte de comida a palacio */
    if (this._almacen.getCantidad() >= this._almacen.getMaxCantidad()) {
      if (this.hayEnvioEnMarcha == false) {
        this.hayEnvioEnMarcha = true;
        this.enviaMaderaHaciaCiudad();
      }
    }
  }

  enviaMaderaHaciaCiudad() {
    num cantidad = this._almacen.restaCantidad(this._almacen.getCantidad());
    Transporte transporteDeMadera = new Transporte (this._almacen, this._capital.getSilos().getAlmacenMadera(), MADERA, cantidad, this );

    transporteDeMadera.calculaViaje();
    this.setStatus ('Enviando madera...');
    this._disp.addTareaRepetitiva(transporteDeMadera, 'envia', Parametros.Transporte_Tiempo_Recalculo_Ruta);
  }

  num getMaderaActual() { return this._almacen.getCantidad(); }
  num getMaxAlmacen() { return this._almacen.getMaxCantidad(); }

  String getStatus() { return this.status; }
  //public setStatus( mensaje: string ) { super.setStatus(mensaje); }

  bool estaActiva() { return (this._filon.getStock() > Parametros.Filon_Vacio); }
}
