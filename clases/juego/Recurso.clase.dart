///TODO
enum TipoRecurso { NATURAL, FABRICADO, MILITAR }

Recurso ORO = new Recurso (1, 'ORO', TipoRecurso.NATURAL);
Recurso POBLACION = new Recurso (2, 'POBLACION', TipoRecurso.MILITAR);
Recurso COMIDA = new Recurso (3, 'COMIDA', TipoRecurso.NATURAL);
Recurso MADERA = new Recurso (4, 'MADERA', TipoRecurso.NATURAL);
Recurso PIEDRA = new Recurso (4, 'PIEDRA', TipoRecurso.NATURAL);
Recurso HIERRO = new Recurso (5, 'HIERRO', TipoRecurso.NATURAL);

class Recurso {
  String _nombre;
  num id;
  TipoRecurso _tipo;

  Recurso (this.id, this._nombre, this._tipo) {}

  String getNombre() { return this._nombre; }
}

class UnidadMilitar extends Recurso {
  num _danyoRecibido = 0;

  num id;
  String nombre;
  num _vidaInicial;
  num _danyoInflingido;
  num _fuerza;
  num _moral;
  num _costeUnitario;
  num maxUnidadesEnEntrenamiento;

  UnidadMilitar (this.id, this.nombre, this._vidaInicial, this._danyoInflingido, this._fuerza, this._moral, this._costeUnitario, this.maxUnidadesEnEntrenamiento) :
        super (id, nombre, TipoRecurso.MILITAR) {
  }

  num getID() { return super.id; }
  String getNombre() { return super.getNombre(); }
  num getCosteUnitario() { return this._costeUnitario; }
  num getMaxUnidadesEnEntrenamiento() { return this.maxUnidadesEnEntrenamiento; }
}

class CivilConHonda extends UnidadMilitar {
  CivilConHonda (num vidaInicial, num danyoInflingido, num fuerza, num moral) :  super ( 1001, 'Civil con honda', vidaInicial, danyoInflingido, fuerza, moral, 1, 10) {}
}

class Soldado extends UnidadMilitar {
  Soldado (num vidaInicial, num danyoInflingido, num fuerza, num moral) : super ( 1002, 'Soldado', vidaInicial, danyoInflingido, fuerza, moral, 10, 10) {}
}

class Arquero extends UnidadMilitar {
  Arquero (num vidaInicial, num danyoInflingido, num fuerza, num moral) : super ( 1003, 'Arquero', vidaInicial, danyoInflingido, fuerza, moral, 5, 10) {}
}

class Lancero extends UnidadMilitar {
  Lancero (num vidaInicial, num danyoInflingido, num fuerza, num moral) : super ( 1002, 'Soldado', vidaInicial, danyoInflingido, fuerza, moral, 10, 10) {}
}