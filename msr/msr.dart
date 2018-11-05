class MSR {
  //el constructor carga los datos de memoria secundaria
  MSR() {

  }

  static void Jugador_add(int id, int imperio, int pais, int rol) {}
  static void Jugador_borra(int id) {}
  static void Jugador_setRol(int rol) {}

  static void Ciudad_add(int id, int pais, int jugador, bool esCapital, int posicion) {} //Pais es el lugar geográfico. jugador es el lugar político
  static void Ciudad_borra() {}
  static void Ciudad_setPropietario(int jugador) {}

  static void Edificio_add(int id, int ciudad, int jugador) {} //Si jugador != ciudad.jugador entonces el edificio ha sido invadido (solo para edificios fuera de la ciudad)
  static void Edificio_borra(int id) {}
  



}