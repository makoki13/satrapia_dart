// ignore_for_file: avoid_print

class InterfazInvestigacion {
  static List<Map<String, Object>> serverData = [];

  static List<Map<String, Object>> getData() {
    return serverData;
  }

  static void generaData(datosJson) {
    serverData.length = 0;

    //datosJson = json.decode(datosJson);

    //List<dynamic> listaJson = datosJson;
    /* final data = datosJson as Map;
    for (final name in data.keys) {
      final value = data[name];
      // ignore: avoid_print
      print('::: $value[nombre]');
    } */

    //print(datosJson);

    List<dynamic> listaJson = datosJson['listaInvestigaciones'];
    int i = 0;
    for (var value in listaJson) {
      //print('---> ${value['listaInvestigaciones']}');
      //print('$i---> ${value['subinvestigaciones']}');
      List<dynamic> listaJsonSubinvestigaciones = value['subinvestigaciones'];
      int j = 0;
      List<Map<String, Object>> dataSubinvestigaciones = [];

      for (var subinvestigacion in listaJsonSubinvestigaciones) {
        List<dynamic> listaJsonItems = subinvestigacion['items'];
        int k = 0;
        List<Map<String, Object>> dataItems = [];
        for (var item in listaJsonItems) {
          Map<String, Object> mapaItem = {
            'id': k,
            'pid': j,
            'text': item['nombre'],
            'checked': false,
            'show': false,
            'children': [],
          };
          k++;
          dataItems.add(mapaItem);
        }

        Map<String, Object> mapaSubinvestigacion = {
          'id': j,
          'pid': i,
          'text': subinvestigacion['nombre'],
          'checked': true,
          'show': false,
          'children': dataItems,
        };

        j++;

        dataSubinvestigaciones.add(mapaSubinvestigacion);
      }

      Map<String, Object> mapa = {
        'id': i,
        'pid': 0,
        'text': value['nombre'],
        'checked': true,
        'show': false,
        'children': dataSubinvestigaciones,
      };
      serverData.add(mapa);

      i++;
    }

    /*    
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
    */

    /* serverData.add({
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
    });
    serverData.add({
      "checked": true,
      "show": false,
      "children": [],
      "id": 2,
      "pid": 0,
      "text": "Parent title 2",
    });
    serverData.add({
      "checked": true,
      "children": [],
      "id": 3,
      "pid": 0,
      "show": false,
      "text": "Parent title 3",
    });
 */
  }
}
