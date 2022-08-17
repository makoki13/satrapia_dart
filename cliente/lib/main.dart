// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'SATRAPIA 0.0.1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _selectedIndex = 0;

  int poblacion = 0;
  int oro = 0;
  int comida = 0;
  int madera = 0;
  int piedra = 0;
  int hierro = 0;
  int porcImpuestos = 0;

  int moduloActual = 1;

  _MyHomePageState();

  List<Widget> getModuloActual() {
    //print('modulo actual $moduloActual');
    switch (moduloActual) {
      case 2:
        return <Widget>[
          Text("Comida: ${comida.toString()}",
              style: const TextStyle(fontSize: 20)),
          Text('Madera: ${madera.toString()}',
              style: const TextStyle(fontSize: 20)),
          Text('Piedra: ${piedra.toString()}',
              style: const TextStyle(fontSize: 20)),
          Text('Hierro: ${hierro.toString()}',
              style: const TextStyle(fontSize: 20)),
        ];

      case 3:
        return <Widget>[
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.redAccent,
              ),
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: investigaciones.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    color: Colors.white,
                    child: Center(child: Text(investigaciones[index])),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              )),
        ];

      case 4:
        return <Widget>[
          const Text("Infanteria", style: TextStyle(fontSize: 20)),
          const Text('Arqueros', style: TextStyle(fontSize: 20)),
          const Text('Lanceros', style: TextStyle(fontSize: 20)),
          const Text('Caballería', style: TextStyle(fontSize: 20)),
          const Text('Asalto', style: TextStyle(fontSize: 20)),
        ];

      default:
        return <Widget>[
          Text("Oro en el tesoro: ${oro.toString()}",
              style: const TextStyle(fontSize: 20)),
          Text('Población actual: ${poblacion.toString()}',
              style: const TextStyle(fontSize: 20)),
          Text('Impuestos: ${porcImpuestos.toString()}',
              style: const TextStyle(fontSize: 20)),
        ];
    }
  }

  void setModuloActual(int modulo) {
    setState(() {
      moduloActual = modulo;
      getModuloActual();
    });
  }

  /* @override
  void setState(VoidCallback fn) {
    print("setState override");
    super.setState(fn);
  } */

  Future<http.Response> fetchData() {
    print('cliente: fetchData...');
    var uri = Uri.parse('http://localhost:2710/api/?comando=1');
    return http.get(uri);
  }

  void fillListaInvestigaciones(lista) {
    //Map<String, dynamic> listaJson = json.decode(lista);
    List<dynamic> listaJson = lista['listaInvestigaciones'];
    investigaciones.length = 0;
    for (var value in listaJson) {
      investigaciones.add(value['nombre']);
      //print('---> ${value['nombre']}');
    }
  }

  Future getItems() async {
    var response = await fetchData();
    var data = jsonDecode(response.body);

    //print(data);

    data['ciudades'].forEach((ciudad) {
      if (ciudad['es_capital'] == true) {
        setState(() {
          fillListaInvestigaciones(ciudad['centroDeInvestigacion']);
          poblacion = ciudad['palacio']['poblacion'];
          oro = ciudad['palacio']['oro'];
          comida = ciudad['almacen']['comida'];
          madera = ciudad['almacen']['madera'];
          piedra = ciudad['almacen']['piedra'];
          hierro = ciudad['almacen']['hierro'];
          porcImpuestos = data['porc_impuestos'];
        });
      }
    });

    addPantalla(oro);
  }

  @override
  initState() {
    super.initState();
    //Future<void>.delayed(new Duration(seconds: 5),createlist());
    Future<String>.delayed(
            const Duration(seconds: 1), () => '["123", "456", "789"]')
        .then((String value) {
      setState(() {
        print("setState initState");
        createlist();
      });
    });

    Timer.periodic(const Duration(seconds: 5), (timer) {
      getItems();
      //print(timer.tick.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    if (entries.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Loading..."),
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: SizedBox(
              width: 300,
              child: Text(widget.title),
            ),
            centerTitle: true,
            leading: const Icon(Icons.account_circle_rounded),
            actions: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  "Población",
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.yellowAccent,
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 38.0),
                child: Center(
                    child: Text(
                  poblacion.toString(),
                  textScaleFactor: 1.5,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                )),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  "Oro",
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.yellowAccent,
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 38.0),
                child: Center(
                    child: Text(
                  oro.toString(),
                  textScaleFactor: 1.5,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                )),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  "Comida",
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.yellowAccent,
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 38.0),
                child: Center(
                    child: Text(
                  comida.toString(),
                  textScaleFactor: 1.5,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                )),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  "Madera",
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.yellowAccent,
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 38.0),
                child: Center(
                    child: Text(
                  madera.toString(),
                  textScaleFactor: 1.5,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                )),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  "Piedra",
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.yellowAccent,
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 238.0),
                child: Center(
                    child: Text(
                  piedra.toString(),
                  textScaleFactor: 1.5,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                )),
              )
            ],
          ),
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.redAccent,
                      ),
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: entries.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 50,
                            color: Colors.amber[colorCodes[index]],
                            child: Center(child: Text(entries[index])),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 20,
                    endIndent: 0,
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(36.0),
                                primary: Colors.black,
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                setModuloActual(1);
                              },
                              child: const Text('PALACIO'),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(36.0),
                                primary: Colors.black,
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                setModuloActual(2);
                              },
                              child: const Text('ALMACÉN'),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(36.0),
                                primary: Colors.black,
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                setModuloActual(3);
                              },
                              child: const Text('CENTRO INVESTIGACIÓN'),
                            ),
                            const TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Cuartel',
                              ),
                            ),
                            const TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Granjas',
                                filled: true,
                                hoverColor: Colors.orange,
                              ),
                            ),
                            const TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Serrerias',
                              ),
                            ),
                            const TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Canteras',
                              ),
                            ),
                            const TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Minas de Hierro',
                              ),
                            ),
                            const TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Minas de Oro',
                              ),
                            ),
                          ],
                        )),
                  ),
                  const VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 20,
                    endIndent: 0,
                    width: 10,
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black26,
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: getModuloActual(),
                                ),
                              ]))),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Inicio',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'School',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
          ));
    }
  }

  Future<void> createlist() async {
    Future<http.Response> loadImperio() {
      print('loadImperio...');
      var uri = Uri.parse('http://localhost:2710/api/?comando=1&jugador=1');
      print(uri.port);
      return http.post(uri);
      /* return http.post(Uri.parse('https://jsonplaceholder.typicode.com/albums')); */
    }

    Future<http.Response> fetchCiudades() {
      return fetchData();
      /* print('fetchCiudades...');
      var uri = Uri.parse('http://localhost:2710/api/?comando=1');
      print(uri.port);
      return http.get(uri); */
    }

    var response = await loadImperio();
    response = await fetchCiudades();
    var data = jsonDecode(response.body);

    data['ciudades'].forEach((ciudad) {
      print('${ciudad['id']} : nombre: ${ciudad['nombre']}');
      entries.add('${ciudad['id']} - ${ciudad['nombre']}');
    });
  }
}

// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
/* 
class _VerticalDividerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.redAccent,
              ),
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    color: Colors.amber[colorCodes[index]],
                    child: Center(child: Text(entries[index])),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
          ),
          const VerticalDivider(
            color: Colors.grey,
            thickness: 1,
            indent: 20,
            endIndent: 0,
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(36.0),
                        primary: Colors.black,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {},
                      child: const Text('PALACIO'),
                    ),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Almacén',
                      ),
                    ),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Centro Investigación',
                      ),
                    ),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Cuartel',
                      ),
                    ),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Granjas',
                        filled: true,
                        hoverColor: Colors.orange,
                      ),
                    ),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Serrerias',
                      ),
                    ),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Canteras',
                      ),
                    ),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Minas de Hierro',
                      ),
                    ),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Minas de Oro',
                      ),
                    ),
                  ],
                )),
          ),
          const VerticalDivider(
            color: Colors.grey,
            thickness: 1,
            indent: 20,
            endIndent: 0,
            width: 10,
          ),
          Expanded(
              flex: 2,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black26,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: getPantalla()))),
        ],
      ),
    );
  }
}
 */
final List<String> investigaciones = <String>[];
final List<String> entries = <String>[];
final List<int> colorCodes = <int>[500, 128, 128];
List<List<Widget>> lista = [];
const int indice = 0;

void addPantalla(int oro) {
  String strOro = oro.toString();
  lista.add(<Widget>[
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("Oro en el tesoro: $strOro", style: const TextStyle(fontSize: 20)),
        Text('Población actual: $strOro', style: const TextStyle(fontSize: 20)),
        Text('Impuestos: $strOro', style: const TextStyle(fontSize: 20)),
      ],
    ),
  ]);
}

List<Widget> getPantalla() {
  return lista[indice];
}
