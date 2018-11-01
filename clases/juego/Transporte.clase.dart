import './Parametros.clase.dart';
import './Punto.clase.dart';
import './Almacen.clase.dart';
import './Recurso.clase.dart';
import './Edificio.clase.dart';
import './TomTom.clase.dart';

class Transporte {
  num tiempoRecalculo = Parametros.Transporte_Tiempo_Recalculo_Ruta;
  num velocidad = Parametros.Transporte_Velocidad;

  Punto posicionActual;
  Punto posicionFinal;
  List<Punto> ruta;

  Almacen _almacenOrigen;
  Almacen _almacenDestino;
  Recurso _recurso;
  num _cantidad;
  Edificio _origen;

  Transporte (this._almacenOrigen, this._almacenDestino, this._recurso, this._cantidad, this._origen) {
    print(this._almacenDestino.toString());

    this.posicionActual = this._almacenOrigen.getPosicion();
    this.posicionFinal = this._almacenDestino.getPosicion();
  }

  myCallBack(String funcion, [List<dynamic>parametros]) {
    switch(funcion) {
      case 'envia': this.envia(); return;
      default:
    }
  }

  calculaViaje() {
    this.ruta = TomTom.calculaViaje (this.posicionActual, this.posicionFinal );
  }

  envia() {
    print("Envia ${this._cantidad}");
    this.modificaPosicionActual();
    print('Pos: ${this.posicionActual.getX()} , ${this.posicionActual.getY()}');
    if ( (this.ruta.length == 0) && (Punto.sonIguales(this.posicionActual, this.posicionFinal)) ) {
      // console.log ('descarga en palacio');
      print("Descarga ${this._cantidad}");
      this._almacenDestino.addCantidad(this._cantidad);
      this._origen.setStatus('Envio finalizado');
      this._origen.hayEnvioEnMarcha = false;
      return -1; // suicidio
    }
  }

  modificaPosicionActual() {
    this.posicionActual = this.ruta.removeAt(0);
  }
}