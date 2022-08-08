//https://medium.com/flutter-community/routing-http-requests-in-a-dart-server-889c0a0475b0

import 'dart:io';
import 'dart:convert';

import 'api/api_proxy.dart';

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

Future<HttpServer> createServer() async {
  final address = InternetAddress.loopbackIPv4;
  const port = 2710;
  return await HttpServer.bind(address, port);
}

//funciones del servidor

void handleGet(HttpRequest request) {
  final path = request.uri.path;
  switch (path) {
    case '/api/':
      handleGetApi(request);
      break;
    default:
      handleGetOther(request);
  }
}

Future<void> handlePost(HttpRequest request) async {
  final path = request.uri.path;
  switch (path) {
    case '/api/':
      handlePostApi(request);
      break;
    default:
      handlePostOther(request);
  }
}

void handleDefault(HttpRequest request) {
  request.response
    ..statusCode = HttpStatus.methodNotAllowed
    ..write('Petición no permitida: ${request.method}.')
    ..close();
}

//handlers...

//GET
void handleGetApi(HttpRequest request) {
  final queryParams = request.uri.queryParameters;
  String resultado = API_PROXY.get_comando(queryParams);
  
  request.response
    ..statusCode = HttpStatus.ok
    ..write(resultado)
    ..close();
}

void handleGetOther(HttpRequest request) {
  request.response
    ..statusCode = HttpStatus.badRequest
    ..close();
}

//POST
void handlePostApi(HttpRequest request) {
  final queryParams = request.uri.queryParameters;
  int resultado = API_PROXY.exec_comando(queryParams);

  final jsonString = jsonEncode(resultado);
  request.response
    ..statusCode = HttpStatus.ok
    ..write(jsonString)
    ..close();
}

void handlePostOther(HttpRequest request) {
  request.response
    ..statusCode = HttpStatus.badRequest
    ..close();
}
