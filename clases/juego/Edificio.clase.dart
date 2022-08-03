import './Punto.clase.dart';

enum TipoEdificio {
  PALACIO,
  ALMACEN,
  CUARTEL,
  MERCADO,
  EMBAJADA,
  TABERNA,
  CENTRO_DE_INVESTIGACION,
  GRANJA,
  MINA_DE_ORO,
  SERRERIA,
  MINA_DE_HIERRO,
  CANTERA_DE_PIEDRA,
  EJERCITO,
  OTROS
}

class Edificio {
  int _id;
  String nombre;
  TipoEdificio tipo;
  Punto posicion;
  int _costeConstruccion;
  int _tiempoConstruccion;

  String status = 'Sin actividad';
  bool hayEnvioEnMarcha = false;

  // Los dos ultimos parametros del constructor hay que quitarlos.
  Edificio(this._id, this.nombre, this.tipo, this.posicion,
      this._costeConstruccion, this._tiempoConstruccion) {}

  /* Es posible que no se usen */
  setCosteConstruccion(int cantidad) {
    this._costeConstruccion = cantidad;
  }

  setTiempoConstruccion(int cantidad) {
    this._tiempoConstruccion = cantidad;
  }

  int getCosteConstruccion() {
    return this._costeConstruccion;
  }

  int getTiempoConstruccion() {
    return this._tiempoConstruccion;
  }

  int getID() {
    return this._id;
  }

  TipoEdificio getTipo() {
    return this.tipo;
  }

  Punto getPosicion() {
    return this.posicion;
  }

  setStatus(String mensaje) {
    this.status = mensaje;
  }

  String getNombre() {
    return this.nombre;
  }

  String getStatus() {
    return this.status;
  }
}
