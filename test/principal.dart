import '../clases/juego/Granja.clase.dart';
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
  Granja miGranja;
  Jugador miLider;
  TipoJugador miTipoJugador;

  Silos miSilo;
  Almacen miAlmacenDeComida;

  Principal() {
    this.miTipoJugador = TipoJugador.EMPERADOR;
    this.miLider = new Jugador(1,1,'Makoki',this.miTipoJugador);
    this.miProvincia = new Provincia(1, 'Provincia de Makoki', this.miLider, false, true);
    this.miPosicion = new Punto(100,100,0);
    this.miCapital = new Capital(1, 'Capital de Makoki', this.miProvincia, this.miPosicion);
    this.miSilo = new Silos(1,'Silos',this.miCapital,this.miDispatcher);

    this.miAlmacenDeComida = new Almacen(1, 'Silo de comida', COMIDA , this.miPosicion, Parametros.MAX_ENTERO);
    this.miSilo.addAlmacen(this.miAlmacenDeComida);
    this.miCapital.setSilos(this.miSilo);
    //print('Mi Silo 2: '+this.miCapital.getSilos().toString());

    this.miDispatcher = new Dispatcher();
    //print ("Creando granja");
    this.miGranja = new Granja(1, 'Granja de Makoki', new Punto(200,200,0), this.miCapital, this.miDispatcher);
  }

  mostrar_info() {
    print(this.miGranja.getNombre());
    print(this.miGranja.getComidaActual());
    print("En Silo: "+ this.miCapital.getSilos().getAlmacenComida().getCantidad().toString());
  }
}