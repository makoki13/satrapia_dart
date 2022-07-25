import './Parametros.clase.dart';
import './Punto.clase.dart';
import './Almacen.clase.dart';
import './Recurso.clase.dart';
import './Edificio.clase.dart';
import './TomTom.clase.dart';

class Transporte {
  int tiempoRecalculo = Parametros.Transporte_Tiempo_Recalculo_Ruta;
  double velocidad = Parametros.Transporte_Velocidad;

  late Punto posicionActual;
  late Punto posicionFinal;
  late List<Punto> ruta;

  Almacen _almacenOrigen;
  Almacen _almacenDestino;
  Recurso _recurso;
  int _cantidad;
  Edificio _origen;

  Transporte(this._almacenOrigen, this._almacenDestino, this._recurso,
      this._cantidad, this._origen) {
    //print(this._almacenDestino.toString());

    this.posicionActual = this._almacenOrigen.get_posicion();
    this.posicionFinal = this._almacenDestino.get_posicion();
  }

  Recurso get_recurso() {
    return this._recurso;
  }

  myCallBack(String funcion, [List<dynamic>? parametros]) {
    switch (funcion) {
      case 'envia':
        this.envia();
        return;
      default:
    }
  }

  calculaViaje() {
    this.ruta = TomTom.calculaViaje(this.posicionActual, this.posicionFinal);
  }

  int envia() {
    //print("Envia ${this._cantidad}");
    this.modificaPosicionActual();
    //print('Pos: ${this.posicionActual.getX()} , ${this.posicionActual.getY()} quedan ${this.ruta.length}');
    if ((this.ruta.length == 0) &&
        (Punto.sonIguales(this.posicionActual, this.posicionFinal))) {
      // console.log ('descarga en palacio');
      this._almacenDestino.add_cantidad(this._cantidad);
      this._origen.setStatus('Envio finalizado');
      this._origen.hayEnvioEnMarcha = false;
      //print("Descarga y suicido ${this._cantidad} has ${this._almacenDestino.getCantidad()} en destino");
      return -1; // suicidio
    } else
      return 0;
  }

  modificaPosicionActual() {
    if (this.ruta.length > 0) this.posicionActual = this.ruta.removeAt(0);
  }
}
