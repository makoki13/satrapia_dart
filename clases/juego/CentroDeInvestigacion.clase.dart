import './Edificio.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';
import './Recurso.clase.dart';
import './Mercado.clase.dart';
import './Taberna.clase.dart';
import './Embajada.clase.dart';

class TipoInvestigacion {
  late List<TipoSubInvestigacion> listaDeSubinvestigaciones;

  int _id;
  String _nombre;

  TipoInvestigacion(this._id, this._nombre) {
    this.listaDeSubinvestigaciones = [];
  }

  addSubinvestigacion(TipoSubInvestigacion subinvestigacion) {
    this.listaDeSubinvestigaciones.add(subinvestigacion);
  }

  int getID() {
    return this._id;
  }

  String getNombre() {
    return this._nombre;
  }

  List<TipoSubInvestigacion> getSubinvestigacionesConseguidos() {
    return this.listaDeSubinvestigaciones.where((subInvestigacion) {
      bool valor = false;
      List<TipoItemInvestigacion> listaItems = subInvestigacion.listaDeItems;
      listaItems.forEach((item) {
        if (item.getConseguido() == true) {
          valor = true;
        }
      });
      return valor;
    }).toList();
  }

  List<TipoSubInvestigacion> getLista() {
    return this.listaDeSubinvestigaciones;
  }
}

class TipoSubInvestigacion {
  late List<TipoItemInvestigacion> listaDeItems;

  int _id;
  String _nombre;
  TipoInvestigacion _investigacion;

  TipoSubInvestigacion(this._id, this._nombre, this._investigacion) {
    this.listaDeItems = [];
  }

  addIteminvestigacion(TipoItemInvestigacion item) {
    this.listaDeItems.add(item);
  }

  int getID() {
    return this._id;
  }

  String getNombre() {
    return this._nombre;
  }

  TipoInvestigacion getTipo() {
    return this._investigacion;
  }

  List<TipoItemInvestigacion> getItemsConseguidos() {
    return this.listaDeItems.where((item) {
      bool valor = false;
      if (item.getConseguido() == true) {
        valor = true;
      }
      return valor;
    }).toList();
  }

  bool estaInvestigada(int indice) {
    return this.listaDeItems[indice].getConseguido();
  }

  List<TipoItemInvestigacion> getLista() {
    return this.listaDeItems;
  }
}

class TipoItemInvestigacion {
  bool _siendoInvestigada = false;

  int _id;
  String _nombre;
  int _precio;
  int _tiempo;
  bool _conseguido;
  TipoSubInvestigacion _subtipo;
  TipoEdificio _edificio;
  Recurso _recurso;

  TipoItemInvestigacion(this._id, this._nombre, this._precio, this._tiempo,
      this._conseguido, this._subtipo, this._edificio, this._recurso);

  TipoEdificio getEdificio() {
    return this._edificio;
  }

  int getPrecio() {
    return this._precio;
  }

  bool getConseguido() {
    return this._conseguido;
  }

  getID() {
    return this._id;
  }

  Recurso getRecurso() {
    return this._recurso;
  }

  TipoSubInvestigacion getSubTipo() {
    return this._subtipo;
  }

  String getNombre() {
    return this._nombre;
  }

  int getTiempo() {
    return this._tiempo;
  }

  setconseguido() {
    this._conseguido = true;
    this._siendoInvestigada = false;
  }

  setInvestigada(bool investigada) {
    this._siendoInvestigada = investigada;
  }

  estaSiendoInvestigada() {
    return this._siendoInvestigada;
  }
}

class CentroDeInvestigacion extends Edificio {
  late List<TipoInvestigacion> listaInvestigaciones;

  late int _id;
  String _nombre;
  late Capital _capital;
  Dispatcher _disp;

  late int _idTipo;
  late int _idSubtipo;
  late int _idItem;
  late Capital _ciudad;

  CentroDeInvestigacion(this._id, this._nombre, this._capital, this._disp)
      : super(_id, _nombre, TipoEdificio.CENTRO_DE_INVESTIGACION,
            _capital.getPosicion(), 0, 0) {
    this._capital.setCentroDeInvestigacion(this);
    this.listaInvestigaciones = [];

    // **************** RECURSOS NATURALES *********************/
    var investigacion = new TipoInvestigacion(1, 'RECURSOS NATURALES');
    var subinvestigacion =
        new TipoSubInvestigacion(1, 'AGRICULTURA', investigacion);
    var itemInvestigacion = new TipoItemInvestigacion(1, 'Cultivar frutales',
        10, 10, false, subinvestigacion, TipoEdificio.GRANJA, COMIDA);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);

    itemInvestigacion = new TipoItemInvestigacion(2, 'Cultivar algodon', 15, 15,
        false, subinvestigacion, TipoEdificio.GRANJA, COMIDA);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    investigacion.addSubinvestigacion(subinvestigacion);

    subinvestigacion = new TipoSubInvestigacion(2, 'GANADERIA', investigacion);
    itemInvestigacion = new TipoItemInvestigacion(1, 'Criar cabras', 25, 5,
        false, subinvestigacion, TipoEdificio.GRANJA, NINGUNO);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    itemInvestigacion = new TipoItemInvestigacion(2, 'Criar gusanos de seda',
        80, 8, false, subinvestigacion, TipoEdificio.GRANJA, COMIDA);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    investigacion.addSubinvestigacion(subinvestigacion);

    subinvestigacion = new TipoSubInvestigacion(3, 'MADERA', investigacion);
    itemInvestigacion = new TipoItemInvestigacion(1, 'Mejorar producción un 5%',
        30, 5, false, subinvestigacion, TipoEdificio.SERRERIA, MADERA);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    investigacion.addSubinvestigacion(subinvestigacion);

    subinvestigacion =
        new TipoSubInvestigacion(4, 'EXTRACCION DE ORO', investigacion);
    itemInvestigacion = new TipoItemInvestigacion(1, 'Mejorar producción un 5%',
        30, 5, false, subinvestigacion, TipoEdificio.MINA_DE_ORO, ORO);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    investigacion.addSubinvestigacion(subinvestigacion);

    subinvestigacion =
        new TipoSubInvestigacion(5, 'EXTRACCION DE PIEDRA', investigacion);
    itemInvestigacion = new TipoItemInvestigacion(1, 'Mejorar producción un 5%',
        30, 5, false, subinvestigacion, TipoEdificio.CANTERA_DE_PIEDRA, PIEDRA);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    investigacion.addSubinvestigacion(subinvestigacion);

    subinvestigacion =
        new TipoSubInvestigacion(6, 'EXTRACCION DE HIERRO', investigacion);
    itemInvestigacion = new TipoItemInvestigacion(1, 'Obtener hierro', 50, 5,
        false, subinvestigacion, TipoEdificio.MINA_DE_HIERRO, HIERRO);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    investigacion.addSubinvestigacion(subinvestigacion);

    subinvestigacion = new TipoSubInvestigacion(7, 'FARMACIA', investigacion);
    itemInvestigacion = new TipoItemInvestigacion(1, 'Antibioticos', 25, 5,
        false, subinvestigacion, TipoEdificio.OTROS, NINGUNO);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    itemInvestigacion = new TipoItemInvestigacion(2, 'Revitalizantes', 80, 8,
        false, subinvestigacion, TipoEdificio.OTROS, NINGUNO);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    itemInvestigacion = new TipoItemInvestigacion(3, 'Narcóticos', 80, 8, false,
        subinvestigacion, TipoEdificio.OTROS, NINGUNO);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    itemInvestigacion = new TipoItemInvestigacion(4, 'Analgésicos', 80, 8,
        false, subinvestigacion, TipoEdificio.OTROS, NINGUNO);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    itemInvestigacion = new TipoItemInvestigacion(5, 'Conservantes', 80, 8,
        false, subinvestigacion, TipoEdificio.OTROS, NINGUNO);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    itemInvestigacion = new TipoItemInvestigacion(6, 'Lubricantes', 80, 8,
        false, subinvestigacion, TipoEdificio.OTROS, NINGUNO);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    itemInvestigacion = new TipoItemInvestigacion(7, 'Colorantes', 80, 8, false,
        subinvestigacion, TipoEdificio.OTROS, NINGUNO);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    investigacion.addSubinvestigacion(subinvestigacion);
    this.listaInvestigaciones.add(investigacion);

    // **************** EJERCITO *********************/
    investigacion = new TipoInvestigacion(2, 'EJERCITO');
    subinvestigacion = new TipoSubInvestigacion(1, 'INFANTERIA', investigacion);
    itemInvestigacion = new TipoItemInvestigacion(
        1,
        'Civil con hondas',
        10,
        5,
        false,
        subinvestigacion,
        TipoEdificio.CUARTEL,
        new CivilConHonda(100, 1, 100, 100));
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    itemInvestigacion = new TipoItemInvestigacion(2, 'Soldado', 50, 15, false,
        subinvestigacion, TipoEdificio.CUARTEL, new Soldado(100, 1, 100, 100));
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    itemInvestigacion = new TipoItemInvestigacion(3, 'Arquero', 50, 15, false,
        subinvestigacion, TipoEdificio.CUARTEL, new Arquero(100, 1, 100, 100));
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    itemInvestigacion = new TipoItemInvestigacion(4, 'Lancero', 50, 15, false,
        subinvestigacion, TipoEdificio.CUARTEL, new Lancero(100, 1, 100, 100));
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    investigacion.addSubinvestigacion(subinvestigacion);

    subinvestigacion = new TipoSubInvestigacion(2, 'CABALLERIA', investigacion);
    investigacion.addSubinvestigacion(subinvestigacion);
    subinvestigacion = new TipoSubInvestigacion(3, 'CARROS', investigacion);
    investigacion.addSubinvestigacion(subinvestigacion);
    subinvestigacion = new TipoSubInvestigacion(4, 'ASALTO', investigacion);
    investigacion.addSubinvestigacion(subinvestigacion);
    subinvestigacion = new TipoSubInvestigacion(5, 'OFICIALES', investigacion);
    investigacion.addSubinvestigacion(subinvestigacion);
    subinvestigacion = new TipoSubInvestigacion(6, 'ESPECIALES', investigacion);
    investigacion.addSubinvestigacion(subinvestigacion);
    subinvestigacion = new TipoSubInvestigacion(7, 'DEFENSA', investigacion);
    itemInvestigacion = new TipoItemInvestigacion(
        1,
        'Puesto de vigilancia básico',
        10,
        5,
        false,
        subinvestigacion,
        TipoEdificio.OTROS,
        NINGUNO);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    itemInvestigacion = new TipoItemInvestigacion(
        2,
        'Puesto de vigilancia medio',
        10,
        5,
        false,
        subinvestigacion,
        TipoEdificio.OTROS,
        NINGUNO);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    itemInvestigacion = new TipoItemInvestigacion(
        3,
        'Puesto de vigilancia avanzado',
        10,
        5,
        false,
        subinvestigacion,
        TipoEdificio.OTROS,
        NINGUNO);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    investigacion.addSubinvestigacion(subinvestigacion);
    this.listaInvestigaciones.add(investigacion);

    // **************** TACTICAS *********************/
    investigacion = new TipoInvestigacion(3, 'TÁCTICAS MILITARES');
    subinvestigacion = new TipoSubInvestigacion(1, 'ORDENACIÓN', investigacion);
    itemInvestigacion = new TipoItemInvestigacion(
        1, 'Unidades en filas', 10, 5, false, subinvestigacion, TipoEdificio.OTROS, NINGUNO);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    investigacion.addSubinvestigacion(subinvestigacion);
    this.listaInvestigaciones.add(investigacion);

    // **************** COMERCIO *********************/
    investigacion = new TipoInvestigacion(4, 'COMERCIO');
    subinvestigacion = new TipoSubInvestigacion(1, 'MERCADO', investigacion);
    itemInvestigacion = new TipoItemInvestigacion(1, 'Construir mercado', 10, 5,
        false, subinvestigacion, TipoEdificio.MERCADO, NINGUNO);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    investigacion.addSubinvestigacion(subinvestigacion);
    subinvestigacion =
        new TipoSubInvestigacion(2, 'ELEMENTOS DE TRANSPORTE', investigacion);
    investigacion.addSubinvestigacion(subinvestigacion);
    subinvestigacion = new TipoSubInvestigacion(3, 'CARRETERAS', investigacion);
    investigacion.addSubinvestigacion(subinvestigacion);
    subinvestigacion = new TipoSubInvestigacion(4, 'ARANCELES', investigacion);
    investigacion.addSubinvestigacion(subinvestigacion);
    this.listaInvestigaciones.add(investigacion);

    // **************** DIPLOMACIA *********************/
    investigacion = new TipoInvestigacion(5, 'DIPLOMACIA');
    subinvestigacion = new TipoSubInvestigacion(1, 'EMBAJADAS', investigacion);
    itemInvestigacion = new TipoItemInvestigacion(1, 'Construir taberna', 10, 5,
        false, subinvestigacion, TipoEdificio.TABERNA, NINGUNO);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    itemInvestigacion = new TipoItemInvestigacion(2, 'Construir embajada', 10,
        5, false, subinvestigacion, TipoEdificio.EMBAJADA, NINGUNO);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    itemInvestigacion = new TipoItemInvestigacion(3, 'Abrir embajada', 10, 5,
        false, subinvestigacion, TipoEdificio.EMBAJADA, NINGUNO);
    subinvestigacion.addIteminvestigacion(itemInvestigacion);
    investigacion.addSubinvestigacion(subinvestigacion);
    subinvestigacion = new TipoSubInvestigacion(2, 'ESPIAS', investigacion);
    investigacion.addSubinvestigacion(subinvestigacion);
    this.listaInvestigaciones.add(investigacion);

    // **************** INDUSTRIA *********************/
    investigacion = new TipoInvestigacion(6, 'INDUSTRIA');
    subinvestigacion = new TipoSubInvestigacion(1, 'ARMAS', investigacion);
    investigacion.addSubinvestigacion(subinvestigacion);
    subinvestigacion =
        new TipoSubInvestigacion(2, 'INVESTIGACION', investigacion);
    investigacion.addSubinvestigacion(subinvestigacion);
    subinvestigacion =
        new TipoSubInvestigacion(3, 'CONSTRUCCIÓN', investigacion);
    investigacion.addSubinvestigacion(subinvestigacion);
    subinvestigacion = new TipoSubInvestigacion(4, 'OCIO', investigacion);
    investigacion.addSubinvestigacion(subinvestigacion);
    this.listaInvestigaciones.add(investigacion);

    // **************** CULTURA *********************/
    investigacion = new TipoInvestigacion(7, 'CULTURA');
    subinvestigacion = new TipoSubInvestigacion(1, 'RELIGIÓN', investigacion);
    investigacion.addSubinvestigacion(subinvestigacion);
    this.listaInvestigaciones.add(investigacion);
  }

  int getID() {
    return this._id;
  }

  String getNombre() {
    return this._nombre;
  }

  List<TipoInvestigacion> getLista() {
    return this.listaInvestigaciones;
  }

  List<TipoInvestigacion> getListaConseguidos() {
    return this.listaInvestigaciones.where((investigacion) {
      bool valor = false;
      List<TipoSubInvestigacion> listaSubInvestigaciones =
          investigacion.listaDeSubinvestigaciones;
      listaSubInvestigaciones.forEach((subInvestigacion) {
        List<TipoItemInvestigacion> listaItems = subInvestigacion.listaDeItems;
        listaItems.forEach((item) {
          if (item.getConseguido() == true) {
            valor = true;
          }
        });
      });
      return valor;
    }).toList();
  }

  List<TipoSubInvestigacion> getListaConseguidosInvestigacion(
      TipoInvestigacion investigacion) {
    return investigacion.listaDeSubinvestigaciones.where((subInvestigacion) {
      bool valor = false;
      List<TipoItemInvestigacion> listaItems = subInvestigacion.listaDeItems;
      listaItems.forEach((item) {
        if (item.getConseguido() == true) {
          valor = true;
        }
      });
      return valor;
    }).toList();
  }

  List<TipoItemInvestigacion> getListaConseguidosPorEdificio(
      TipoEdificio edificio) {
    List<TipoItemInvestigacion> listaElementos = [];
    this.listaInvestigaciones.forEach((investigacion) {
      investigacion.getLista().forEach((subinvestigacion) {
        subinvestigacion.getLista().forEach((item) {
          if ((item.getEdificio() == edificio) &&
              (item.getConseguido() == true)) {
            listaElementos.add(item);
          }
        });
      });
    });

    return listaElementos;
  }

  List<TipoItemInvestigacion> getListaUnidadesMilitaresConseguidas() {
    List<TipoItemInvestigacion> listaElementos = [];
    this.listaInvestigaciones.forEach((investigacion) {
      investigacion.getLista().forEach((subinvestigacion) {
        subinvestigacion.getLista().forEach((item) {
          if ((item.getEdificio() == TipoEdificio.CUARTEL) &&
              (item.getConseguido() == true)) {
            listaElementos.add(item);
          }
        });
      });
    });

    return listaElementos;
  }

  TipoItemInvestigacion getItem(int idTipo, int idSubtipo, int idItem) {
    List<TipoInvestigacion> investigacion = new List<TipoInvestigacion>.from(
        listaInvestigaciones.where((x) => x.getID() == idTipo));
    List<TipoSubInvestigacion> subinvestigacion =
        new List<TipoSubInvestigacion>.from(investigacion[0]
            .listaDeSubinvestigaciones
            .where((x) => x.getID() == idSubtipo));
    List<TipoItemInvestigacion> item = new List<TipoItemInvestigacion>.from(
        subinvestigacion[0].listaDeItems.where((x) => x.getID() == idItem));
    return item[0];
  }

  bool iniciaInvestigacion(
      int idTipo, int idSubtipo, int idItem, Capital ciudad) {
    TipoItemInvestigacion item = this.getItem(idTipo, idSubtipo, idItem);

    int precio = item.getPrecio();
    int cantidadObtenida = this._capital.getPalacio().gastaOro(precio);
    if (cantidadObtenida < precio) {
      print(
          "No se puede pagar $precio con $cantidadObtenida por investigar ${item.getNombre()}");
      this._capital.getPalacio().entraOro(cantidadObtenida);
      this.setStatus(' Se aborta la investigación ' +
          item.getNombre() +
          ': Oro insuficiente');
      return false;
    }

    item.setInvestigada(true);
    print("Se inicia investigar ${item.getNombre()}");
    this._idTipo = idTipo;
    this._idSubtipo = idSubtipo;
    this._idItem = idItem;
    this._ciudad = ciudad;
    this._disp.addTareaRepetitiva(compraInvestigacion, item.getTiempo());
    this.setStatus('Investigando');

    return true;
  }

  int compraInvestigacion() {
    TipoItemInvestigacion item =
        this.getItem(this._idTipo, this._idSubtipo, this._idItem);
    item.setconseguido();
    this.setStatus('Sin actividad');
    if (item.getNombre() == 'Construir mercado') {
      Mercado mercado =
          new Mercado(1, 'Mercado Central', this._ciudad, this._disp);
      this._ciudad.setMercado(mercado);
    }
    if (item.getNombre() == 'Construir taberna') {
      Taberna taberna = new Taberna(1, 'Taberna', this._ciudad, this._disp);
      this._ciudad.setTaberna(taberna);
    }
    if (item.getNombre() == 'Construir embajada') {
      Embajada embajada =
          new Embajada(1, 'Palacio de embajadores', this._ciudad, this._disp);
      this._ciudad.setEmbajada(embajada);
    }
    return -1; // Finalizar tarea
  }

  cancelaInvestigacion() {
    // para la 2.0 :-D
  }

  bool estaComprada(idTipo, idSubtipo, idItem) {
    return true;
    //TipoItemInvestigacion item = this.getItem(idTipo, idSubtipo, idItem);
    //return item.getConseguido();
  }
}
