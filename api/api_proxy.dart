/*
http://localhost:2710/api/?comando=1
http://localhost:2710/api/?comando=1&jugador=1
http://localhost:2710/api/?comando=2&x=10&y=10&z=0
http://localhost:2710/api/?comando=3&x=15&y=15&z=0
*/
import 'dart:convert';
import 'api.dart';

class API_PROXY {
  static String get_comando(Map<String, String> queryParams) {
    String? comando;
    String resultado = '';

    comando = queryParams['comando'] ?? '0';

    int id_comando = int.parse(comando);
    switch (id_comando) {
      case 1:
        resultado = jsonEncode(API.get_json());
        break;
    }

    return resultado;
  }

  static int exec_comando(Map<String, String> queryParams) {
    String? comando = '';
    comando = queryParams['comando'] ?? '0';

    print('params ' + queryParams.toString());

    int id_comando = int.parse(comando);
    switch (id_comando) {
      case 1:
        int jugador = int.parse(queryParams['jugador']!);
        API.generaImperio(jugador);
        break;

      case 2:
        int pos_x = int.parse(queryParams['x']!);
        int pos_y = int.parse(queryParams['y']!);
        int pos_z = int.parse(queryParams['z']!);
        API.creaGranja(pos_x, pos_y, pos_z);
        break;

      case 3:
        int pos_x = int.parse(queryParams['x']!);
        int pos_y = int.parse(queryParams['y']!);
        int pos_z = int.parse(queryParams['z']!);
        API.creaSerreria(pos_x, pos_y, pos_z);
        break;

      case 4:
        int pos_x = int.parse(queryParams['x']!);
        int pos_y = int.parse(queryParams['y']!);
        int pos_z = int.parse(queryParams['z']!);
        API.creaCantera(pos_x, pos_y, pos_z);
        break;

      case 5:
        int pos_x = int.parse(queryParams['x']!);
        int pos_y = int.parse(queryParams['y']!);
        int pos_z = int.parse(queryParams['z']!);
        API.creaMinaDeHierro(pos_x, pos_y, pos_z);
        break;

      case 6:
        int pos_x = int.parse(queryParams['x']!);
        int pos_y = int.parse(queryParams['y']!);
        int pos_z = int.parse(queryParams['z']!);
        API.creaMinaDeOro(pos_x, pos_y, pos_z);
        break;

    }

    return 0;
  }
}
