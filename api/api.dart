//import '../msr/msr.dart'; En un futuro muy lejano
import '../clases/juego/Dispatcher.clase.dart';
import '../clases/juego/Jugador.clase.dart';
import '../clases/juego/Imperio.clase.dart';
import '../clases/juego/Punto.clase.dart';
import '../clases/juego/Capital.clase.dart';

import '../clases/juego/Palacio.clase.dart';
import '../clases/juego/Granja.clase.dart';

class Estructura { 
  static Dispatcher _dispatcher;
  static Jugador _jugador;
  static Imperio _imperio; 
  static Provincia _provincia;
  static Capital capital;
  static List<Localidad> _ciudades;
  static Palacio _palacio;
  static List<Granja> granjas;
}

class API {  

  static Estructura generaImperio(int jugador) { 
    Estructura._dispatcher = new Dispatcher();
    Estructura._jugador = new Jugador(jugador, 1, 'Makoki', TipoJugador.EMPERADOR);
    Estructura._imperio = new Imperio(1,'Imperio de Makoki',Estructura._jugador,false);
    Estructura._provincia = new Provincia(1, 'Provincia de Makoki', Estructura._jugador, false, true);

    Punto _miPosicion = new Punto(100,100,0);
    Estructura.capital = new Capital(1, 'Capital de Makoki', Estructura._provincia, _miPosicion);


    this.miPosicion = new Punto(100,100,0);
    this.miCapital = new Capital(1, 'Capital de Makoki', this.miProvincia, this.miPosicion);
    this.miSilo = new Silos(1,'Silos',this.miCapital,this.miDispatcher);
    return null;
  }
  static Estructura cargaImperio(int jugador) { return null;}

  static void creaEdificio(int id, int ciudad, int jugador) {}
  static void destruyeEdificio() {}
  static void invadeEdificio() {} //Se cambia el jugador propietario

  static void creaGranja() {}
  static void destruyeGranja() {}
  static void invadeGranja() {} //Se cambia el jugador propietario
}