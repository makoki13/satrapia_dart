import 'dart:async';

class Tarea {  
  Function _funcion;
  DateTime _vencimiento;
  int _delta;
  bool _eliminada = false;

  Tarea (this._funcion, this._vencimiento, this._delta) {}

  DateTime getVencimiento() {return this._vencimiento; }

  setVencimiento () {
    this._vencimiento.add(new Duration(seconds: this._delta));
  }

  String getNombreFuncion() { return this._funcion.toString(); }

  int execFuncion() {
    int valor = this._funcion();  
    return valor;
  }
}

class Dispatcher {
  List<Tarea> listaDeTareas = new List<Tarea>();

  Dispatcher() {    
    const oneSec = const Duration(microseconds: 500000);
    new Timer.periodic(oneSec, (Timer t) => this.ejecuta(this.listaDeTareas.toList()));
  }

  addTareaRepetitiva(Function f, int tiempo) {
    DateTime nuevoVencimiento;
    Tarea t;

    nuevoVencimiento = new DateTime.now();
    nuevoVencimiento.add(new Duration(seconds: tiempo));

    t = new Tarea(f, nuevoVencimiento, tiempo);

    this.listaDeTareas.add(t);
  }

  nada() {}

  ejecuta(List<Tarea> lista) {    
    DateTime horaActual = new DateTime.now();
    int cantidadTareas = lista.length;

    if (cantidadTareas > 0) {      
      lista.forEach((tarea) {
        if (tarea._eliminada == false) {
          if (tarea.getVencimiento().isBefore(horaActual)) {
            tarea.setVencimiento();
            int rt = tarea.execFuncion();
            if (rt == -1) {              
              tarea._eliminada = true;
            }            
          }
        }
      });
    }
  }
}