import '../api/api.dart';
import '../clases/juego/Dispatcher.clase.dart';

import '../clases/juego/Punto.clase.dart';
import '../clases/juego/Granja.clase.dart';
import '../clases/juego/Serreria.clase.dart';
import '../clases/juego/Cantera.clase.dart';
import '../clases/juego/Mina.clase.dart';
import '../clases/juego/CentroDeInvestigacion.clase.dart';
import '../clases/juego/Cuartel.clase.dart';

class Principal {
  Dispatcher miDispatcher;
  bool primeraVez = true;

  void visualizador() {        
    print("\x1B[2J\x1B[0;0H");
    print("--------------------- S·A·T·R·A·P·I·A  V.0.0 ----------------------------------");
    print("");
    print(" Población : ${API.getPoblacionActual()}  ---- Oro : ${API.getOroActual()}");
    print("............................................................");
    print(" Silos :::  Comida: ${API.getStockComida()} ---- Madera: ${API.getStockMadera()} ---- " + 
      "Piedra: ${API.getStockPiedra()} ---- Hierro: ${API.getStockHierro()}");
    print("............................................................");
    print(" * Granjas: ${API.numGranjas()}");
    List<Granja> listaGranjas = API.listaGranjas();
    Iterator i = listaGranjas.iterator;
    while (i.moveNext()) { print("   - ${i.current.getNombre()}"); }

    print(" * Serrerias: ${API.numSerrerias()}");
    List<Serreria> listaSerrerias = API.listaSerrerias();
    i = listaSerrerias.iterator;
    while (i.moveNext()) { print("   - ${i.current.getNombre()}"); }

    print(" * Canteras: ${API.numCanteras()}");
    List<Cantera> listaCanteras = API.listaCanteras();
    i = listaCanteras.iterator;
    while (i.moveNext()) { print("   - ${i.current.getNombre()}"); }

    print(" * Minas de hierro: ${API.numMinasDeHierro()}");
    List<MinaDeHierro> listaMinasDeHierro = API.listaMinasDeHierro();
    i = listaMinasDeHierro.iterator;
    while (i.moveNext()) { print("   - ${i.current.getNombre()}"); }
    print("............................................................");
    print("............................................................");
    /*
    print(" INVESTIGACIONES");
    List<TipoInvestigacion> investigaciones = API.getListaInvestigaciones();
    i = investigaciones.iterator;
    Iterator j; Iterator k;
    while (i.moveNext()) { 
      print("   - ${i.current.getNombre()}");       
      List<TipoSubInvestigacion> listaSubinvestigaciones = i.current.getLista();
      j = listaSubinvestigaciones.iterator;
      while (j.moveNext()) { 
        print("      - ${j.current.getNombre()}");
        List <TipoItemInvestigacion> listaItems = j.current.getLista();
        k = listaItems.iterator;
        while (k.moveNext()) { 
          print("         - ${k.current.getNombre()} Investigada: ${k.current.getConseguido()}");
        }
      }
    }
 
    i = investigaciones.iterator;
    while (i.moveNext()) { 
      List<TipoSubInvestigacion> listaSubinvestigaciones = i.current.getLista();
      j = listaSubinvestigaciones.iterator;
      while (j.moveNext()) { 
        List <TipoItemInvestigacion> listaItems = j.current.getLista();
        k = listaItems.iterator;
        while (k.moveNext()) { 
          //print("Investigando: ${k.current.getNombre()}");
          if (k.current.getConseguido() == false) {
            print("Investigando: ${k.current.getNombre()}");
            API.investiga(i.current.getID(),j.current.getID(),k.current.getID(), API.getCapital());            
            return;
          }
        }
      }
    }
    */
    print("............................................................");
    print("............................................................");
    print(" EJERCITO ");
    
    if (primeraVez == true) {
      API.entrenaCivilesConHonda(20);
      API.entrenaSoldados(10); 
      primeraVez = false;
    } 

    List<Unidades> listaUnidades = API.getListaTropas();
    i = listaUnidades.iterator;    
    while (i.moveNext()) { print("   - ${i.current.unidad.getNombre()} Cantidad: ${i.current.cantidad}"); }
    print("............................................................");
    print("............................................................");

  }

  Principal() {
    this.miDispatcher = new Dispatcher();

    API.generaImperio(0);
  
    this.miDispatcher.addTareaRepetitiva(visualizador, 1);

    Punto posicion = new Punto(105,103,0);
    API.creaGranja(posicion);
    posicion = new Punto(106,103,0);
    API.creaGranja(posicion);
    //API.destruyeGranja(1);

    posicion = new Punto(103,107,0);
    API.creaSerreria(posicion);
    posicion = new Punto(101,106,0);
    API.creaSerreria(posicion);
    //API.destruyeSerreria(1);

    posicion = new Punto(104,105,0);
    API.creaCantera(posicion);
    posicion = new Punto(105,104,0);
    API.creaCantera(posicion);
    //API.destruyeSerreria(1);

    posicion = new Punto(111,115,0);
    API.creaMinaDeHierro(posicion);
    posicion = new Punto(110,108,0);
    API.creaMinaDeHierro(posicion);
    //API.destruyeMinaDeHierro(1);
  }
}