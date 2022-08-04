import './Edificio.clase.dart';
import './Parametros.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';
import './Extractor.clase.dart';
import './Productor.clase.dart';
import './Silo.clase.dart';
import './Recurso.clase.dart';
import './Transporte.clase.dart';
import './Punto.clase.dart';

class Cantera extends Edificio {
  int costeConstruccion = Parametros.Cantera_Construccion_Coste;
  int tiempoConstruccion = Parametros.Cantera_Construccion_Tiempo;
  int cantidadMaxima = Parametros.Cantera_Productor_CantidadMaxima;

  int _id;
  String _nombre;
  Punto _posicion;
  Capital _capital;
  Dispatcher _disp;
  late Extractor _canteros;
  late Productor _filon;
  late Silo _silo;

  Cantera(this._id, this._nombre, this._posicion, this._capital, this._disp)
      : super(
            _id,
            _nombre,
            TipoEdificio.CANTERA_DE_PIEDRA,
            _posicion,
            Parametros.Cantera_Construccion_Coste,
            Parametros.Cantera_Construccion_Tiempo) {
    this._capital.addCantera(this);

    this._filon = new Productor(new Punto(0, 0, -1), PIEDRA,
        this.cantidadMaxima, Parametros.Cantera_Productor_Ratio);
    this._silo = new Silo(68, 'Cantera de piedra', PIEDRA, this._posicion,
        Parametros.Cantera_Almacen_Capacidad);
    this._canteros = new Extractor(
        this._filon, this._silo, Parametros.Cantera_Cosecha_Tamanyo);

    this._disp.addTareaRepetitiva(extrae, Parametros.Cantera_Cosecha_Tamanyo);

    this.setStatus('Sin envios actuales');
  }

  int getID() {
    return this._id;
  }

  String getNombre() {
    return this._nombre;
  }

  Silo getSilo() {
    return this._silo;
  }

  String toString() {
    return this._nombre;
  }

  extrae() {
    int cantidad = this._canteros.getCantidad();
    this._silo.add_cantidad(cantidad);

    /* Si el almacen alcanza el tope enviar un transporte de piedra a palacio */
    if (this._silo.get_cantidad() >= this._silo.get_max_cantidad()) {
      if (this.hayEnvioEnMarcha == false) {
        this.hayEnvioEnMarcha = true;
        this.enviaPiedraHaciaCiudad();
      }
    }
  }

  enviaPiedraHaciaCiudad() {
    int cantidad = this._silo.resta_cantidad(this._silo.get_cantidad());
    Transporte transporteDePiedra = new Transporte(
        this._posicion, this._capital.getAlmacen(), PIEDRA, cantidad, this);

    transporteDePiedra.calculaViaje();
    this.setStatus('Enviando piedra...');
    this._disp.addTareaRepetitiva(
        transporteDePiedra.envia, Parametros.Transporte_Tiempo_Recalculo_Ruta);
  }

  int getPiedraActual() {
    return this._silo.get_cantidad();
  }

  int getMaxAlmacen() {
    return this._silo.get_max_cantidad();
  }

  String getStatus() {
    return this.status;
  }

  setStatus(String mensaje) {
    super.setStatus(mensaje);
  }

  bool estaActiva() {
    return (this._filon.getStock() > Parametros.Filon_Vacio);
  }

  Map<String, dynamic> toJson() => {'id': _id, 'nombre': _nombre};
}
