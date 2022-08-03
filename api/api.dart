//import '../msr/msr.dart'; En un futuro muy lejano
import '../clases/juego/Dispatcher.clase.dart';
import '../clases/juego/Parametros.clase.dart';
import '../clases/juego/Recurso.clase.dart';
import '../clases/juego/Silo.clase.dart';

import '../clases/juego/Jugador.clase.dart';
import '../clases/juego/Imperio.clase.dart';
import '../clases/juego/Punto.clase.dart';
import '../clases/juego/Capital.clase.dart';

import '../clases/juego/Palacio.clase.dart';
import '../clases/juego/Almacen.clase.dart';
import '../clases/juego/Cuartel.clase.dart';
import '../clases/juego/Ejercito.clase.dart';
import '../clases/juego/CentroDeInvestigacion.clase.dart';

import '../clases/juego/Granja.clase.dart';
import '../clases/juego/Serreria.clase.dart';
import '../clases/juego/Cantera.clase.dart';
import '../clases/juego/Mina.clase.dart';

class Estructura {
  static late Dispatcher _dispatcher;
  static late Jugador _jugador;
  static late Imperio _imperio;
  static late Provincia _provincia;
  static late Capital _capital;
  static late List<Localidad> _ciudades;
  static late List<Granja> granjas;
  static late List<Serreria> serrerias;
  static late List<Cantera> canteras;
  static late List<MinaDeHierro> minasDeHierro;
}

class API {
  static void generaImperio(int jugador) {
    Estructura._dispatcher = new Dispatcher();

    print("api dispatcher id: " +
        Estructura._dispatcher.get_instancia().toString());

    Estructura._jugador =
        new Jugador(jugador, 1, 'Makoki', TipoJugador.EMPERADOR);
    Estructura._imperio =
        new Imperio(1, 'Imperio de Makoki', Estructura._jugador, false);
    Estructura._provincia = new Provincia(
        1, 'Provincia de Makoki', Estructura._jugador, false, true);

    Punto _miPosicion = new Punto(100, 100, 0);
    Estructura._capital =
        new Capital(1, 'Capital de Makoki', Estructura._provincia, _miPosicion);

    Estructura._ciudades = [];
    Estructura._ciudades.add(Estructura._capital);

    //generar palacio
    Estructura._capital.setPalacio(new Palacio(
        1, 'Palacio de Makoki', Estructura._capital, Estructura._dispatcher));

    //generar almacen y silos
    Estructura._capital.setAlmacen(
        new Almacen(1, 'Silos', _miPosicion, Estructura._dispatcher));
    Estructura._capital.getAlmacen().addSilo(new Silo(
        1, 'Silo de comida', COMIDA, _miPosicion, Parametros.MAX_ENTERO));
    Estructura._capital.getAlmacen().addSilo(new Silo(
        2, 'Silo de madera', MADERA, _miPosicion, Parametros.MAX_ENTERO));
    Estructura._capital.getAlmacen().addSilo(new Silo(
        3, 'Silo de piedra', PIEDRA, _miPosicion, Parametros.MAX_ENTERO));
    Estructura._capital.getAlmacen().addSilo(new Silo(
        4, 'Silo de hierro', HIERRO, _miPosicion, Parametros.MAX_ENTERO));

    //generar cuartel
    Estructura._capital.setCuartel(new Cuartel(
        1, 'Cuartel de Makoki', Estructura._capital, Estructura._dispatcher));

    //generar centro de investigacion
    Estructura._capital.setCentroDeInvestigacion(new CentroDeInvestigacion(
        1,
        'Centro de investigación de Makoki',
        Estructura._capital,
        Estructura._dispatcher));

    Estructura.granjas = [];
    Estructura.serrerias = [];
    Estructura.canteras = [];
    Estructura.minasDeHierro = [];

    return;
  }

  bool cargaImperio(int jugador) {
    return true;
  }

  static Capital getCapital() {
    return Estructura._capital;
  }

  Imperio get_imperio() {
    return Estructura._imperio;
  }

  static int getPoblacionActual() {
    return Estructura._capital.getPalacio().getPoblacionActual();
  }

  static int getOroActual() {
    return Estructura._capital.getPalacio().getOroActual();
  }

  static int getStockComida() {
    return Estructura._capital.getAlmacen().getSiloComida().get_cantidad();
  }

  static int getStockMadera() {
    return Estructura._capital.getAlmacen().getSiloMadera().get_cantidad();
  }

  static int getStockPiedra() {
    return Estructura._capital.getAlmacen().getSiloPiedra().get_cantidad();
  }

  static int getStockHierro() {
    return Estructura._capital.getAlmacen().getSiloHierro().get_cantidad();
  }

  /* GRANJAS */
  static int creaGranja(Punto posicion) {
    int indice = Estructura.granjas.length + 1;
    Granja _granja = new Granja(indice, 'Granja de Makoki $indice', posicion,
        Estructura._capital, Estructura._dispatcher);
    Estructura.granjas.add(_granja);
    return indice;
  }

  static int destruyeGranja(int id) {
    Iterator i = Estructura.granjas.iterator;
    int indice = 0;
    bool encontrado = false;
    while (i.moveNext()) {
      if (i.current.getID() == id) {
        encontrado = true;
        break;
      }
      indice++;
    }
    if (encontrado == true) {
      Estructura.granjas.removeAt(indice);
      return 0;
    }

    return -1;
  }

  static void invadeGranja(int id) {} //Se cambia el jugador propietario

  static int numGranjas() {
    return Estructura.granjas.length;
  }

  static List<Granja> listaGranjas() {
    return Estructura.granjas;
  }

  /* SERRERIAS */
  static int creaSerreria(Punto posicion) {
    int indice = Estructura.serrerias.length + 1;
    Serreria _serreria = new Serreria(indice, 'Serreria de Makoki $indice',
        posicion, Estructura._capital, Estructura._dispatcher);
    Estructura.serrerias.add(_serreria);
    return indice;
  }

  static int destruyeSerreria(int id) {
    Iterator i = Estructura.serrerias.iterator;
    int indice = 0;
    bool encontrado = false;
    while (i.moveNext()) {
      if (i.current.getID() == id) {
        encontrado = true;
        break;
      }
      indice++;
    }
    if (encontrado == true) {
      Estructura.serrerias.removeAt(indice);
      return 0;
    }

    return -1;
  }

  static void invadeSerreria(int id) {} //Se cambia el jugador propietario
  static int numSerrerias() {
    return Estructura.serrerias.length;
  }

  static List<Serreria> listaSerrerias() {
    return Estructura.serrerias;
  }

  /* CANTERAS */
  static int creaCantera(Punto posicion) {
    int indice = Estructura.canteras.length + 1;
    Cantera _cantera = new Cantera(indice, 'Cantera de Makoki $indice',
        posicion, Estructura._capital, Estructura._dispatcher);
    Estructura.canteras.add(_cantera);
    return indice;
  }

  static int destruyeCantera(int id) {
    Iterator i = Estructura.canteras.iterator;
    int indice = 0;
    bool encontrado = false;
    while (i.moveNext()) {
      if (i.current.getID() == id) {
        encontrado = true;
        break;
      }
      indice++;
    }
    if (encontrado == true) {
      Estructura.canteras.removeAt(indice);
      return 0;
    }

    return -1;
  }

  static void invadeCantera(int id) {} //Se cambia el jugador propietario
  static int numCanteras() {
    return Estructura.canteras.length;
  }

  static List<Cantera> listaCanteras() {
    return Estructura.canteras;
  }

  /* MINAS DE HIERRO */
  static int creaMinaDeHierro(Punto posicion) {
    int indice = Estructura.minasDeHierro.length + 1;
    MinaDeHierro _minaDeHierro = new MinaDeHierro(
        indice,
        'Mina de hierro de Makoki $indice',
        posicion,
        Estructura._capital,
        Estructura._dispatcher);
    Estructura.minasDeHierro.add(_minaDeHierro);
    return indice;
  }

  static int destruyeMinaDeHierro(int id) {
    Iterator i = Estructura.minasDeHierro.iterator;
    int indice = 0;
    bool encontrado = false;
    while (i.moveNext()) {
      if (i.current.getID() == id) {
        encontrado = true;
        break;
      }
      indice++;
    }
    if (encontrado == true) {
      Estructura.minasDeHierro.removeAt(indice);
      return 0;
    }

    return -1;
  }

  static void invadeMinaDeHierro(int id) {} //Se cambia el jugador propietario
  static int numMinasDeHierro() {
    return Estructura.canteras.length;
  }

  static List<MinaDeHierro> listaMinasDeHierro() {
    return Estructura.minasDeHierro;
  }

  /* INVESTIGACIONES */
  static List<TipoInvestigacion> getListaInvestigaciones() {
    return Estructura._capital.getCentroDeInvestigacion().getLista();
  }

  static void investiga(int idTipo, int idSubtipo, int idItem, Capital ciudad) {
    Estructura._capital
        .getCentroDeInvestigacion()
        .iniciaInvestigacion(idTipo, idSubtipo, idItem, ciudad);
  }

  /* TROPAS */
  static List<Unidades> getListaTropas() {
    return Estructura._capital.getCuartel().getTropas();
  }

  static void entrenaCivilesConHonda(int cantidad) {
    CivilConHonda leva = new CivilConHonda(1, 10, 10, 80);
    Unidades unidad = new Unidades(leva, cantidad);
    Estructura._capital.getCuartel().entrena(unidad, cantidad);
  }

  static int entrenaSoldados(int cantidad) {
    Soldado leva = new Soldado(3, 20, 20, 100);
    Unidades unidad = new Unidades(leva, cantidad);
    return Estructura._capital.getCuartel().entrena(unidad, cantidad);
  }

  static List<Unidades> getListaEjercito() {
    return Estructura._capital.getCuartel().getEjercito().getTropas();
  }

  static void traspasaCivilesConHondaAlEjercito(cantidad) {
    CivilConHonda leva = new CivilConHonda(3, 20, 20, 100);
    Estructura._capital.getCuartel().transfiere(leva, cantidad);
  }

  static void traspasaSoldadosAlEjercito(cantidad) {
    Soldado leva = new Soldado(3, 20, 20, 100);
    Estructura._capital.getCuartel().transfiere(leva, cantidad);
  }
}
