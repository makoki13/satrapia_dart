import '../clases/juego/Granja.clase.dart';
import '../clases/juego/Serreria.clase.dart';
import '../clases/juego/Cantera.clase.dart';
import '../clases/juego/Mina.clase.dart';
import '../clases/juego/Palacio.clase.dart';
import '../clases/juego/Recurso.clase.dart';
import '../clases/juego/Almacen.clase.dart';
import '../clases/juego/Silos.clase.dart';
import '../clases/juego/Capital.clase.dart';
import '../clases/juego/Imperio.clase.dart';
import '../clases/juego/Punto.clase.dart';
import '../clases/juego/Dispatcher.clase.dart';
import '../clases/juego/Jugador.clase.dart';
import '../clases/juego/Parametros.clase.dart';

class Principal {
  Provincia miProvincia;
  Punto miPosicion;
  Dispatcher miDispatcher;
  Capital miCapital;
  Palacio _miPalacio;
  Granja _miGranja;
  Serreria _miSerreria;
  Cantera _miCantera;
  MinaDeHierro _miMinaDeHierro;
  MinaDeOro _miMinaDeOro;
  Jugador miLider;
  TipoJugador miTipoJugador;

  Silos miSilo;
  Almacen miAlmacenDeComida, miAlmacenDeMadera, miAlmacenDePiedra, miAlmacenDeHierro;

  void visualizador() {    
    print("\x1B[2J\x1B[0;0H");
    print("---------------------SATRAPIA V.0.0----------------------------------");
    print("");
    print("Población: ${miCapital.palacio.getPoblacionActual()}  ---- Oro......: ${miCapital.palacio.getOroActual()}");
    print("............................................................");
    print("Silos :::  Comida: ${miSilo.getAlmacenComida().getCantidad()} ---- Madera: ${miSilo.getAlmacenMadera().getCantidad()} ---- " + 
      "Piedra: ${miSilo.getAlmacenPiedra().getCantidad()} ---- Hierro: ${miSilo.getAlmacenHierro().getCantidad()}");
  }

  Principal() {
    this.miDispatcher = new Dispatcher();

    this.miTipoJugador = TipoJugador.EMPERADOR;
    this.miLider = new Jugador(1,1,'Makoki',this.miTipoJugador);
    this.miProvincia = new Provincia(1, 'Provincia de Makoki', this.miLider, false, true);
    this.miPosicion = new Punto(100,100,0);
    this.miCapital = new Capital(1, 'Capital de Makoki', this.miProvincia, this.miPosicion);
    this.miSilo = new Silos(1,'Silos',this.miCapital,this.miDispatcher);

    this._miPalacio  = new Palacio(1,'Palacio de Makoki',this.miCapital,this.miDispatcher);
    this.miCapital.setPalacio(this._miPalacio);
    
    this.miAlmacenDeComida = new Almacen(1, 'Silo de comida', COMIDA , this.miPosicion, Parametros.MAX_ENTERO); this.miSilo.addAlmacen(this.miAlmacenDeComida);
    this.miAlmacenDeMadera = new Almacen(1, 'Silo de madera', MADERA , this.miPosicion, Parametros.MAX_ENTERO); this.miSilo.addAlmacen(this.miAlmacenDeMadera);
    this.miAlmacenDePiedra = new Almacen(1, 'Silo de piedra', PIEDRA , this.miPosicion, Parametros.MAX_ENTERO); this.miSilo.addAlmacen(this.miAlmacenDePiedra);
    this.miAlmacenDeHierro = new Almacen(1, 'Silo de hierro', HIERRO , this.miPosicion, Parametros.MAX_ENTERO); this.miSilo.addAlmacen(this.miAlmacenDeHierro);    
    this.miCapital.setSilos(this.miSilo);
    //print('Mi Silo 2: '+this.miCapital.getSilos().toString());
        
    this._miGranja = new Granja(1, 'Granja de Makoki', new Punto(105,103,0), this.miCapital, this.miDispatcher);
    this._miSerreria = new Serreria(1, 'Serreria de Makoki', new Punto(103,101,0), this.miCapital, this.miDispatcher);
    this._miCantera = new Cantera(1, 'Cantera de Makoki', new Punto(104,104,0), this.miCapital, this.miDispatcher);
    this._miMinaDeHierro = new MinaDeHierro(1, 'Mina de hierro de Makoki', new Punto(106,101,0), this.miCapital, this.miDispatcher);
    this._miMinaDeOro = new MinaDeOro(1, 'Mina de oro de Makoki', new Punto(109,110,0), this.miCapital, this.miDispatcher);

    this.miDispatcher.addTareaRepetitiva(visualizador, 1);
  }

  mostrar_info() {
    /*
    print(this.miGranja.getNombre());
    print(this.miGranja.getComidaActual());
    print("En Silo: "+ this.miCapital.getSilos().getAlmacenComida().getCantidad().toString());
    */
  }
}