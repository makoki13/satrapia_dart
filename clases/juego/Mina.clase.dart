import './Extractor.clase.dart';
import './Productor.clase.dart';
import './Almacen.clase.dart';
import './Edificio.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';
import './Recurso.clase.dart';
import './Transporte.clase.dart';

class Mina extends Edificio {
  static num costeConstruccion = 250;
  static num tiempoContruccion = 5;

  Extractor mineros;
  Productor filon;
  Almacen almacen;

  num id;
  String nombre;
  Capital capital;
  Dispatcher disp;
  TipoEdificio tipoEdificio;
  Recurso recurso;
  Almacen almacenDestino;

  Mina (this.id, this.nombre, this.capital, this.disp, this.tipoEdificio, this.recurso, this.almacenDestino) : super (id, nombre, tipoEdificio, capital.getPosicion(), 100, 10) {
    this.filon = new Productor ( null, recurso, 20000, 20, 1);
    this.almacen = new Almacen ( 67, 'Filón de ' + recurso.getNombre() , recurso, this.capital.getPosicion(), 100);
    const cantidadInicial = 20;
    this.mineros = new Extractor (this.filon, this.almacen, cantidadInicial);
    this.disp.addTareaRepetitiva(this, 'extrae', 1, almacenDestino);
    this.setStatus ('Sin envios actuales');
  }

  extrae(almacenDestino) {
    num cantidad = this.mineros.getCantidad();
    this.almacen.addCantidad (cantidad);

    /* Si el almacen alcanza el tope enviar un transporte de recursos a palacio */
    if (this.almacen.getCantidad() >= this.almacen.getMaxCantidad()) {
      if (this.hayEnvioEnMarcha == false) {
        this.hayEnvioEnMarcha = true;
        this.enviaRecursosHaciaPalacio(almacenDestino);
      }
    }
  }

  enviaRecursosHaciaPalacio(almacenDestino) {
    num cantidad = this.almacen.restaCantidad(this.almacen.getCantidad());
    Transporte transporteDeRecurso = new Transporte (this.almacen, almacenDestino, this.recurso, cantidad, this );

    transporteDeRecurso.calculaViaje();
    this.setStatus ('Enviando ' + this.recurso.getNombre() + '...');
    this.disp.addTareaRepetitiva(transporteDeRecurso, 'envia', 1);
  }

  num getCantidadAlmacenActual() { return this.almacen.getCantidad(); }
  num getMaxAlmacen() { return this.almacen.getMaxCantidad(); }

  String getStatus() { return this.status; }
  //public setStatus( mensaje: string ) { super.setStatus(mensaje); }

  bool estaActiva() { return (this.filon.getStock() > 0); }
}


/* *************************************************************************************** */
/* CLASE MINA DE ORO */
class MinaDeOro extends Mina {
  static num costeConstruccion = 250;
  static num tiempoContruccion = 5;

  num id;
  String nombre;
  Capital capital;
  Dispatcher disp;

  MinaDeOro (this.id, this.nombre, this.capital, this.disp) : super (id, nombre, capital, disp, TipoEdificio.MINA_DE_ORO, ORO, capital.getPalacio().getAlmacen()) {
    this.capital.addMinaDeOro(this);
  }

  num getOroActual() { return this.almacen.getCantidad(); }

  bool estaActiva() { return (this.filon.getStock() > 0); }
}

/* *****************************************************************************************/
/* CLASE MINA DE HIERRO */
class MinaDeHierro extends Mina {
  static num costeConstruccion = 250;
  static num tiempoContruccion = 5;

  num id;
  String nombre;
  Capital capital;
  Dispatcher disp;

  MinaDeHierro (this.id, this.nombre, this.capital, this.disp) : super (id, nombre, capital, disp, TipoEdificio.MINA_DE_HIERRO, HIERRO, capital.getPalacio().getAlmacen()) {
    this.capital.addMinaDeHierro(this);
  }

  num getHierroActual() { return this.almacen.getCantidad(); }
}
