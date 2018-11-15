import './Edificio.clase.dart';
import './Recurso.clase.dart';
import './CentroDeInvestigacion.clase.dart';
import './Capital.clase.dart';
import './Dispatcher.clase.dart';
import './Ejercito.clase.dart';

class Cuartel extends Edificio {
  List<Unidades> _unidades;

  int id;
  String nombre;
  Capital _capital;
  Dispatcher _disp;
  Ejercito _ejercito;

  Cuartel (this.id, this.nombre, this._capital, this._disp) : super (id, nombre, TipoEdificio.CUARTEL, _capital.getPosicion(), 0, 0) {
    this._capital.setCuartel(this);
    this._unidades = new  List< Unidades >();
    this._ejercito = new Ejercito(1, 'Ejercito de la ciudad de ${this._capital.getNombre()}', _capital.getPosicion(), this._capital, this._disp);
  }

  List<Unidades> getTropas() { return this._unidades; }

  Ejercito getEjercito() {
    return this._ejercito;
  }

  UnidadMilitar _tipoUnidad, _tipoUnidadCivilConHonda;
  int _cantidad, _cantidadCivilConHonda;

  void transfiere(UnidadMilitar tipo, int cantidad) {
    int indiceElemento = -1;
    int indice = 0;
    this._unidades.forEach( (x) {
      if (x.unidad.getID() == tipo.getID()) {indiceElemento = indice; }      
      indice++;
    });
    
    if ( indiceElemento != -1) {      
      print ("${tipo.getNombre()} : ${this._unidades[indiceElemento].cantidad} : $cantidad");
      if (this._unidades[indiceElemento].cantidad <= cantidad) {
        this._ejercito.addUnidades(tipo, this._unidades[indiceElemento].cantidad);
        this._unidades[indiceElemento].cantidad = 0;
      }
      else {        
        this._ejercito.addUnidades(tipo, cantidad);
        this._unidades[indiceElemento].cantidad -= cantidad;
      }
    }    
  }

  addUnidades () {
    UnidadMilitar tipo = this._tipoUnidad; int cantidad = this._cantidad;
    int indiceElemento = -1;
    int indice = 0;
    this._unidades.forEach( (x) {
      if (x.unidad.getID() == tipo.getID()) {indiceElemento = indice; }
      indice++;
    });

    if ( indiceElemento == -1) {
      Unidades nuevaUnidad = new Unidades(tipo, cantidad);
      this._unidades.add (nuevaUnidad);
    } else {
      this._unidades[indiceElemento].cantidad += cantidad;
    }

    this.setStatus ('Sin actividad');

    return -1;
  }

  addUnidadesCivilesConHonda () {
    UnidadMilitar tipo = _tipoUnidadCivilConHonda; int cantidad = this._cantidadCivilConHonda;
    int indiceElemento = -1;
    int indice = 0;
    this._unidades.forEach( (x) {
      if (x.unidad.getID() == tipo.getID()) {indiceElemento = indice; }
      indice++;
    });

    if ( indiceElemento == -1) {
      Unidades nuevaUnidad = new Unidades(tipo, cantidad);
      this._unidades.add (nuevaUnidad);
    } else {
      this._unidades[indiceElemento].cantidad += cantidad;
    }

    this.setStatus ('Sin actividad');

    return -1;
  }
  
  List<Unidades> getTipoUnidadesPermitidas() {
    List<Unidades> lista = new List< Unidades >();    
    CentroDeInvestigacion myCI = this._capital.getCentroDeInvestigacion();

    myCI.getListaUnidadesMilitaresConseguidas().forEach ( (item) {
      int indice = item.getID();
      bool existe = false;
      switch (indice) {
        case 1:
          this._unidades.forEach( (x) {
            if (x.unidad.getID() == 1001) {lista.add (x); existe = true; }
          });
          if (existe == false ) {
            Unidades nuevaUnidad = new Unidades(new CivilConHonda(100, 1, 1, 100) , 0);
            this._unidades.add (nuevaUnidad);
            lista.add (nuevaUnidad);
          }
          break;

        case 2:
          this._unidades.forEach( (x) {
            if (x.unidad.getID() == 1002) {lista.add (x); existe = true; }
          });
          if (existe == false ) {
            Unidades nuevaUnidad = new Unidades(new Soldado (100, 1, 100, 100) , 0);
            this._unidades.add (nuevaUnidad);
            lista.add (nuevaUnidad);
          }
          break;

        default:
          // console.log ('UNIDAD 0:::: ' + indice);
      }
    });

    return lista;
  }

  int _entrenaCivilesConHonda([int cantidad = 100]) {    
    CivilConHonda tipoUnidad = new CivilConHonda(100, 1, 1, 100);
    int maxUnidadesEnEntrenamiento = tipoUnidad.getMaxUnidadesEnEntrenamiento();
    if (cantidad == 0) { cantidad = maxUnidadesEnEntrenamiento; }
    if (cantidad > maxUnidadesEnEntrenamiento) { cantidad = maxUnidadesEnEntrenamiento; }
    CentroDeInvestigacion myCI = this._capital.getCentroDeInvestigacion();
    if (myCI.estaComprada(2, 1, 1)) {
      this.setStatus ('Entrenando');
      bool esCorrecto = true;
      int precio = tipoUnidad.getCosteUnitario();
      int importeTotal = precio * cantidad;
      int cantidadObtenida = this._capital.getPalacio().gastaOro(importeTotal);
      if (cantidadObtenida < importeTotal ) {
            this._capital.getPalacio().entraOro(cantidadObtenida);
            esCorrecto = false;            
          }

      if (esCorrecto == false) return -1;

      this._tipoUnidadCivilConHonda = tipoUnidad;
      this._cantidadCivilConHonda = cantidad;

      this._disp.addTareaRepetitiva(addUnidadesCivilesConHonda, 5);
    } else {
      // console.log(' No se puede entrenar "Civiles con honda". La investigación no está realizada.');
    }

    return 0;
  }

  int _entrenaSoldados([int cantidad = 0]) {    
    if (this.getStatus=='Entrenando') return -1;
    Soldado tipoUnidad = new Soldado(100, 1, 100, 100);
    int maxUnidadesEnEntrenamiento = tipoUnidad.getMaxUnidadesEnEntrenamiento();
    if (cantidad == 0) { cantidad = maxUnidadesEnEntrenamiento; }
    if (cantidad > maxUnidadesEnEntrenamiento) { cantidad = maxUnidadesEnEntrenamiento; }
    CentroDeInvestigacion myCI = this._capital.getCentroDeInvestigacion();
    if (myCI.estaComprada(2, 1, 2)) {      
      this.setStatus ('Entrenando');
      bool esCorrecto = true;

      int precio = tipoUnidad.getCosteUnitario();
      int importeTotal = precio * cantidad;
      int cantidadObtenida = this._capital.getPalacio().gastaOro(importeTotal);
      if (cantidadObtenida < importeTotal ) {
        print("No hay pasta");
        this._capital.getPalacio().entraOro(cantidadObtenida);
        esCorrecto = false;        
      }
      
      if (esCorrecto == false) return -1;

      this._tipoUnidad = tipoUnidad;
      this._cantidad = cantidad;

      this._disp.addTareaRepetitiva(addUnidades, 5);
    } 
    else {
        print(' No se puede entrenar "Soldados". La investigación no está realizada.');
    }

    return 0;
  }

  int entrena( Unidades tipoUnidad, int cantidad) {
    int resp;
    switch (tipoUnidad.unidad.getID()) {
      case 1001:
        resp = this._entrenaCivilesConHonda(cantidad);
        break;
      case 1002:
        resp = this._entrenaSoldados(cantidad);
        break;
    }

    return resp;
  }
}