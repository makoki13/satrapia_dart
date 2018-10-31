import 'dart:async';

class Scheduler {

  Timer _timer;

  Function f;
  Duration d;
  int iteraciones;

  Scheduler (this.f, this.d, this.iteraciones) {
    if (iteraciones<2)
      this._timer = new Timer(this.d, this.f);
    else {
      this._timer = new Timer.periodic(this.d, (_timer) => monitor());
    }
  }

  monitor() {
    print("Ticker: "+this._timer.tick.toString());
    if(this._timer.tick >= this.iteraciones) {
      print("Ticker finalizando: ");
      this._timer.cancel();
      print("Ticker ya finalizado: ");
    }
    else {
      this.f();
    }
  }
}