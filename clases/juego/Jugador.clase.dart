enum TipoJugador { SIN_JUEGO, EMPERADOR, SATRAPA, JEFE_DE_TRIBU }

class Jugador {
  num _idJugador;
  num _idUsuario;
  String _nombre;
  TipoJugador _tipo;
  Jugador (this._idJugador, this._idUsuario, this._nombre, this._tipo) {

  }
}