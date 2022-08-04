import '../api/api.dart';
import '../clases/juego/Dispatcher.clase.dart';

import '../clases/juego/Punto.clase.dart';
import '../clases/juego/Granja.clase.dart';
import '../clases/juego/Serreria.clase.dart';
import '../clases/juego/Cantera.clase.dart';
import '../clases/juego/Mina.clase.dart';
import '../clases/juego/Ejercito.clase.dart';

import '../clases/juego/CentroDeInvestigacion.clase.dart';

import 'dart:convert';
import 'dart:io';

class Principal {
  late Dispatcher miDispatcher;
  bool primeraVez = true;
  String comando = '';

  int visualizador() {
    if (this.comando == 's') {
      exit(0);
    }

    Iterator i;

    print("\x1B[2J\x1B[0;0H");
    print(
        "--------------------- S·A·T·R·A·P·I·A  V.0.0 ----------------------------------");
    print("");
    /* print(
        " Población : ${API.getPoblacionActual()}  ---- Oro : ${API.getOroActual()}");
    print("............................................................");
    print("............................................................"); */
    if (this.comando == 'r') {
      print(" * Granjas: ${API.numGranjas()}");
      List<Granja> listaGranjas = API.listaGranjas();
      Iterator i = listaGranjas.iterator;
      while (i.moveNext()) {
        print(
            "   - ${i.current.getNombre()} : comida actual ${i.current.getComidaActual()} : maxima cantidad ${i.current.getSilo().get_max_cantidad()}");
      }

      print(" * Serrerias: ${API.numSerrerias()}");
      List<Serreria> listaSerrerias = API.listaSerrerias();
      i = listaSerrerias.iterator;
      while (i.moveNext()) {
        print(
            "   - ${i.current.getNombre()} : ${i.current.getMaderaActual()} : ${i.current.getSilo().get_max_cantidad()}");
      }

      print(" * Canteras: ${API.numCanteras()}}");
      List<Cantera> listaCanteras = API.listaCanteras();
      i = listaCanteras.iterator;
      while (i.moveNext()) {
        print(
            "   - ${i.current.getNombre()} : ${i.current.getPiedraActual()} : ${i.current.getSilo().get_max_cantidad()}");
      }

      print(" * Minas de hierro: ${API.numMinasDeHierro()}");
      List<MinaDeHierro> listaMinasDeHierro = API.listaMinasDeHierro();
      i = listaMinasDeHierro.iterator;
      while (i.moveNext()) {
        print("   - ${i.current.getNombre()} : ${i.current.getHierroActual()} : ${i.current.getSilo().get_max_cantidad()} : " +
            "stock inicial filon ${i.current.get_cantidad_filon()} : stock actual filon: ${i.current.get_stock_filon()}");
      }

      print("............................................................");
      print("............................................................");
    }

    if (this.comando == 'i') {
      print(" INVESTIGACIONES");
      List<TipoInvestigacion> investigaciones = API.getListaInvestigaciones();
      i = investigaciones.iterator;
      Iterator j;
      Iterator k;
      bool muestra_investigacion;
      bool muestra_subinvestigacion;

      while (i.moveNext()) {
        muestra_investigacion = false;
        List<TipoSubInvestigacion> listaSubinvestigaciones =
            i.current.getLista();
        j = listaSubinvestigaciones.iterator;
        while (j.moveNext()) {
          List<TipoItemInvestigacion> listaItems = j.current.getLista();
          k = listaItems.iterator;
          while (k.moveNext()) {
            if (k.current.getConseguido() == false) {
              muestra_investigacion = true;
            }
          }
        }

        if (muestra_investigacion == true) {
          print("   - ${i.current.getNombre()}");

          /* List<TipoSubInvestigacion> listaSubinvestigaciones =
              i.current.getLista(); */
          j = listaSubinvestigaciones.iterator;
          while (j.moveNext()) {
            muestra_subinvestigacion = false;
            List<TipoItemInvestigacion> listaItems = j.current.getLista();
            k = listaItems.iterator;
            while (k.moveNext()) {
              if (k.current.getConseguido() == false) {
                muestra_subinvestigacion = true;
              }
            }

            if (muestra_subinvestigacion == true) {
              print("      - ${j.current.getNombre()}");

              /* List<TipoSubInvestigacion> listaSubinvestigaciones =
                  i.current.getLista();
              j = listaSubinvestigaciones.iterator;
              while (j.moveNext()) { */

              List<TipoItemInvestigacion> listaItems = j.current.getLista();
              k = listaItems.iterator;
              while (k.moveNext()) {
                if (k.current.getConseguido() == false) {
                  stdout.write(
                      "         - ${k.current.getNombre()} (${k.current.getPrecio()}): ${k.current.getConseguido()}");
                }
              }
              print("");
              //}
            }
          }
        }
      }

      i = investigaciones.iterator;
      while (i.moveNext()) {
        List<TipoSubInvestigacion> listaSubinvestigaciones =
            i.current.getLista();
        j = listaSubinvestigaciones.iterator;
        while (j.moveNext()) {
          List<TipoItemInvestigacion> listaItems = j.current.getLista();
          k = listaItems.iterator;
          while (k.moveNext()) {
            //print("Investigando: ${k.current.getNombre()}");
            if (k.current.getConseguido() == false) {
              //print("Investigando: ${k.current.getNombre()}");
              API.investiga(i.current.getID(), j.current.getID(),
                  k.current.getID(), API.getCapital());
            }
          }
        }
      }

      print("............................................................");
      print("............................................................");
    }

    if (this.comando == 'e') {
      print(" SOLDADESCA ");
      if (primeraVez == true) {
        API.entrenaCivilesConHonda(30);
        API.entrenaSoldados(20);

        primeraVez = false;
      }

      API.traspasaCivilesConHondaAlEjercito(5);
      API.traspasaSoldadosAlEjercito(5);

      List<Unidades> listaUnidades = API.getListaTropas();
      i = listaUnidades.iterator;
      while (i.moveNext()) {
        print(
            "   - ${i.current.unidad.getNombre()} Cantidad: ${i.current.cantidad}");
      }
      print("............................................................");
      print(" EJERCITO ");
      List<Unidades> listaUnidadesEjercito = API.getListaEjercito();
      if (listaUnidadesEjercito.isNotEmpty) i = listaUnidadesEjercito.iterator;
      while (i.moveNext()) {
        print(
            "   - ${i.current.unidad.getNombre()} Cantidad: ${i.current.cantidad}");
      }

      print("............................................................");
      print("............................................................");
    }

    print("............................................................");
    print(
        " Población : ${API.getPoblacionActual()}  ---- Oro : ${API.getOroActual()}");
    print("............................................................");
    print(" Silos :::  Comida: ${API.getStockComida()} ---- Madera: ${API.getStockMadera()} ---- " +
        "Piedra: ${API.getStockPiedra()} ---- Hierro: ${API.getStockHierro()}");
    print("");
    print(
        "===================================================================================================");
    print(
        "[r] Recursos . [i] Investigaciones . [e] Ejercito . [] limpiar . [s] Salir");

    //int orden = get_ch().nextInt(3);

    return 1;
  }

  Principal() {
    stdin.echoMode = false;
    stdin.lineMode = false;

    this.miDispatcher = new Dispatcher();

    API.generaImperio(0);

    this.miDispatcher.addTareaRepetitiva(visualizador, 1);

    Punto posicion = new Punto(105, 103, 0);
    API.creaGranja(posicion);
    posicion = new Punto(106, 103, 0);
    API.creaGranja(posicion);
    //API.destruyeGranja(1);

    posicion = new Punto(103, 107, 0);
    API.creaSerreria(posicion);
    posicion = new Punto(101, 106, 0);
    API.creaSerreria(posicion);
    //API.destruyeSerreria(1);

    posicion = new Punto(104, 105, 0);
    API.creaCantera(posicion);
    posicion = new Punto(105, 104, 0);
    API.creaCantera(posicion);
    //API.destruyeSerreria(1);

    posicion = new Punto(111, 115, 0);
    API.creaMinaDeHierro(posicion);
    posicion = new Punto(110, 108, 0);
    API.creaMinaDeHierro(posicion);
    //API.destruyeMinaDeHierro(1);

    stdin.transform(utf8.decoder).forEach((element) => this.comando = element);
  }
}
