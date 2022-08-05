//https://medium.com/flutter-community/routing-http-requests-in-a-dart-server-889c0a0475b0

import 'dart:io';
import 'dart:convert';

//variables de prueba
const fruit = ['apple', 'banana', 'peach', 'pear'];
var myStringStorage = 'Mi primer servidor Dart';

Future<void> handleRequests(HttpServer server) async {
  await for (HttpRequest request in server) {
    switch (request.method) {
      case 'GET':
        handleGet(request);
        break;
      case 'POST':
        handlePost(request);
        break;
      default:
        handleDefault(request);
    }
  }
}

Future<void> main() async {
  final server = await createServer();
  print('Server started: ${server.address} port ${server.port}');
  await handleRequests(server);
}

Future<HttpServer> createServer() async {
  final address = InternetAddress.loopbackIPv4;
  const port = 4040;
  return await HttpServer.bind(address, port);
}

//funciones del servidor

void handleGet(HttpRequest request) {
  final path = request.uri.path;
  switch (path) {
    case '/fruit':
      handleGetFruit(request);
      break;
    case '/vegetables':
      handleGetVegetables(request);
      break;
    default:
      handleGetOther(request);
  }
}

Future<void> handlePost(HttpRequest request) async {
  myStringStorage = await utf8.decoder.bind(request).join();
  request.response
    ..write('Got it. Thanks.')
    ..close();
}

void handleDefault(HttpRequest request) {
  request.response
    ..statusCode = HttpStatus.methodNotAllowed
    ..write('Petición no permitida: ${request.method}.')
    ..close();
}

void handleGetFruit(HttpRequest request) {
  // 1
  final queryParams = request.uri.queryParameters;
  final prefix = queryParams['prefix'];

  // 2
  final matches = fruit
      .where(
        (item) => item.startsWith(prefix!),
      )
      .toList();
  // 3
  if (matches.isEmpty) {
    request.response
      ..statusCode = HttpStatus.notFound
      ..close();
    // 4
  } else {
    final jsonString = jsonEncode(matches);
    request.response
      ..statusCode = HttpStatus.ok
      ..write(jsonString)
      ..close();
  }
}

void handleGetVegetables(HttpRequest request) {
  request.response
    ..statusCode = HttpStatus.ok
    ..write(myStringStorage)
    ..close();
}

void handleGetOther(HttpRequest request) {
  request.response
    ..statusCode = HttpStatus.badRequest
    ..close();
}
