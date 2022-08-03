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

  Almacen _almacenDestino;
  Recurso _recurso;
  int _cantidad;
  Edificio _origen;

  Transporte(Punto posicion_inicial, this._almacenDestino, this._recurso,
      this._cantidad, this._origen) {
    //print(this._almacenDestino.toString());

    this.posicionActual = posicion_inicial;
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
    this.modificaPosicionActual();

    if ((this.ruta.length == 0) &&
        (Punto.sonIguales(this.posicionActual, this.posicionFinal))) {
      this._almacenDestino.add_cantidad(this._recurso, this._cantidad);
      this._origen.setStatus('Envio finalizado');
      this._origen.hayEnvioEnMarcha = false;

      return -1; // suicidio
    } else
      return 0;
  }

  modificaPosicionActual() {
    if (this.ruta.length > 0) this.posicionActual = this.ruta.removeAt(0);
  }
}
