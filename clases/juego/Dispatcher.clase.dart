import 'dart:async';

class Tarea {
  dynamic _clase;
  String _funcion;
  DateTime _vencimiento;
  num _delta;
  List<dynamic> _parametros;
  bool eliminada = false;

  Tarea (this._clase, this._funcion, this._vencimiento, this._delta, [this._parametros]) {}

  DateTime getVencimiento() {return this._vencimiento; }

  setVencimiento () {
    this._vencimiento.add(new Duration(seconds: this._delta));
  }

  String getNombreFuncion() { return this._funcion; }

  num execFuncion() {
    //print("execFuncion --- clase: "+this._clase.toString()+" -- funcion: "+this._funcion);
    return this._clase.myCallBack(this._funcion, this._parametros);
  }
}

class Dispatcher {
  List<Tarea> listaDeTareas = new List<Tarea>();

  Dispatcher() {
    const oneSec = const Duration(seconds:1);
    new Timer.periodic(oneSec, (Timer t) => this.ejecuta(this.listaDeTareas.toList()));
  }

  addTareaRepetitiva(Object c, String f, num tiempo, [ dynamic param]) {
    DateTime nuevoVencimiento;
    Tarea t;

    nuevoVencimiento = new DateTime.now();
    nuevoVencimiento.add(new Duration(seconds: tiempo));

    //print("Generando nueva Tarea Repetitiva: "+c.toString()+" --> "+f+" Tiempo: "+tiempo.toString());

    t = new Tarea(c, f, nuevoVencimiento, tiempo, param);

    this.listaDeTareas.add(t);
  }

  nada() {}

  ejecuta(List<Tarea> lista) {
    //print('ejecutando dispatcher...');
    DateTime horaActual = new DateTime.now();
    num numTareas = lista.length;

    if (numTareas > 0) {
      num indice = 0;
      lista.forEach((tarea) {
        if (tarea.eliminada == false) {
          if (tarea.getVencimiento().isBefore(horaActual)) {
            tarea.setVencimiento();
            num rt = tarea.execFuncion();
            //if ( rt == -1 ) this.listaDeTareas.removeAt(indice);
            if (rt == -1) tarea.eliminada = true;
            indice++;
          }
        }
      });
    }
  }
}