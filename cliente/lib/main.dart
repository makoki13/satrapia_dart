// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter_tree/flutter_tree.dart';

import './interfaz_investigacion.dart';

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

  int impuestos = 0;
  int porcImpuestos = 0;
  int gastoPalacio = 0;

  int moduloActual = 1;

  List<TreeNodeData> treeData = [];

  _MyHomePageState();

  /* final serverData = [
    {
      "checked": true,
      "children": [
        {
          "checked": true,
          "show": false,
          "children": [],
          "id": 11,
          "pid": 1,
          "text": "Child title 11",
        },
      ],
      "id": 1,
      "pid": 0,
      "show": false,
      "text": "Parent title 1",
    },
    {
      "checked": true,
      "show": false,
      "children": [],
      "id": 2,
      "pid": 0,
      "text": "Parent title 2",
    },
    {
      "checked": true,
      "children": [],
      "id": 3,
      "pid": 0,
      "show": false,
      "text": "Parent title 3",
    },
  ]; */

  /// Map server data to tree node data
  TreeNodeData mapServerDataToTreeData(Map data) {
    return TreeNodeData(
      extra: data,
      title: data['text'],
      expaned: data['show'],
      checked: data['checked'],
      children:
          List.from(data['children'].map((x) => mapServerDataToTreeData(x))),
    );
  }

  /* Future<List<TreeNodeData>> _load(TreeNodeData parent) async {
    await Future.delayed(const Duration(seconds: 1));
    final data = [
      TreeNodeData(
        title: 'Carga node 1',
        expaned: false,
        checked: true,
        children: [],
        extra: null,
      ),
      TreeNodeData(
        title: 'Carga node 2',
        expaned: false,
        checked: false,
        children: [],
        extra: null,
      ),
    ];

    return data;
  } */

  /// Generate tree data

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
              color: Colors.yellow,
            ),
            child: TreeView(
              data: treeData,
              lazy: true,
              //load: _load,
              showActions: true,
              showCheckBox: true,
              showFilter: false,
              append: (parent) {
                print(parent.extra);
                return TreeNodeData(
                  title: 'Appended',
                  expaned: true,
                  checked: true,
                  children: [],
                );
              },
              onLoad: (node) {
                print('onLoad');
                print(node);
              },
              onAppend: (node, parent) {
                print('onAppend');
                print(node);
              },
              onCheck: (checked, node) {
                print('checked');
                print('onCheck');
                print(node);
              },
              onCollapse: (node) {
                print('onCollapse');
                print(node);
              },
              onExpand: (node) {
                print('onExpand');
                print(node);
              },
              onRemove: (node, parent) {
                print('onRemove');
                print(node);
              },
              onTap: (node) {
                print('onTap');
                print(node);
              },
            ),
          ),
        ];

      case 4:
        return <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 120,
            width: double.maxFinite,
            child: Card(
                elevation: 5,
                child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 2.0, color: Colors.red),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Stack(children: <Widget>[
                          Align(
                              alignment: Alignment.centerRight,
                              child: Stack(children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(left: 10, top: 5),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: const <Widget>[
                                            Text("Infanteriaxxxxx",
                                                style: TextStyle(fontSize: 20)),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Spacer(),
                                            Text("Infanteria III",
                                                style: TextStyle(fontSize: 20)),
                                          ],
                                        ),
                                        Row(
                                          children: const <Widget>[
                                            Text("Infanteria V",
                                                style: TextStyle(fontSize: 20)),
                                          ],
                                        )
                                      ],
                                    ))
                              ])),
                        ])))),
          ),
          const Text('Arqueros', style: TextStyle(fontSize: 20)),
          const Text('Lanceros', style: TextStyle(fontSize: 20)),
          const Text('Caballería', style: TextStyle(fontSize: 20)),
          const Text('Asalto', style: TextStyle(fontSize: 20)),
        ];

      case 5:
        return <Widget>[
          const Text("Producción actual:", style: TextStyle(fontSize: 20)),
          const Text('Producción máxima', style: TextStyle(fontSize: 20)),
          const Text('Enviando:', style: TextStyle(fontSize: 20)),
          const Text('Tiempo de llegada', style: TextStyle(fontSize: 20)),
        ];

      default:
        return <Widget>[
          Text("Oro en el tesoro: ${oro.toString()}",
              style: const TextStyle(fontSize: 20)),
          Text('Población actual: ${poblacion.toString()}',
              style: const TextStyle(fontSize: 20)),
          Text('Impuestos: ${impuestos.toString()}',
              style: const TextStyle(fontSize: 20)),
          Row(
            children: <Widget>[
              Text('Porc. impuestos: ${porcImpuestos.toString()}',
                  style: const TextStyle(fontSize: 20)),
              Expanded(
                child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      // for version 2 and greater youcan also use this
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        labelText: "whatever you want",
                        hintText: "whatever you want",
                        icon: Icon(Icons.phone_iphone)),
                    onSubmitted: (value) {
                      setState(() {
                        enviaOrdenSetImpuestos(7, int.parse(value));
                        porcImpuestos = int.parse(value);
                      });
                      //print(value);
                      // or do whatever you want when you are done editing
                      // call your method/print values etc
                    }),
              ),
            ],
          ),
          Text('Gasto palacio: ${gastoPalacio.toString()}',
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
    InterfazInvestigacion.generaData(lista);

    List<Map<String, Object>> serverData = InterfazInvestigacion.getData();
    treeData = List.generate(
      serverData.length,
      (index) => mapServerDataToTreeData(serverData[index]),
    ).toList();

    /* //Map<String, dynamic> listaJson = json.decode(lista);
    List<dynamic> listaJson = lista['listaInvestigaciones'];
    investigaciones.length = 0;
    for (var value in listaJson) {
      investigaciones.add(value['nombre']);
      //print('---> ${value['nombre']}');
    } */
  }

  Future getItems() async {
    var response = await fetchData();
    var data = jsonDecode(response.body);

    //print(data['gasto_palacio']);
    //print(data['porc_impuestos']);

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
          impuestos = ciudad['palacio']['impuestos'];
          porcImpuestos = data['porc_impuestos'];
          gastoPalacio = data['gasto_palacio'];
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
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(36.0),
                                primary: Colors.black,
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                setModuloActual(4);
                              },
                              child: const Text('CUARTEL'),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(36.0),
                                primary: Colors.black,
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                setModuloActual(5);
                              },
                              child: const Text('GRANJAS'),
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

  Future<http.Response> enviaOrden(int comando, String params) async {
    print('enviando comando $comando con parametros $params');
    var uri = Uri.parse(
        'http://localhost:2710/api/?comando=$comando&jugador=1$params');
    print(uri.port);
    return http.post(uri);
  }

  Future<http.Response> enviaOrdenSetImpuestos(int comando, int valor) async {
    String params = "&valor=$valor";
    return enviaOrden(comando, params);
    /* print('enviando comando...');
    var uri =
        Uri.parse('http://localhost:2710/api/?comando=$comando&jugador=1');
    print(uri.port);
    return http.post(uri); */
    /* return http.post(Uri.parse('https://jsonplaceholder.typicode.com/albums')); */
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
