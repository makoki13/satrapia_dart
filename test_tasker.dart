import 'test/principal.dart';
import 'webserver.dart';

Future<void> main() async {
  //lanzamos el servidor
  final server = await createServer();
  print('Server started: ${server.address} port ${server.port}');
  await handleRequests(server);

  Principal miPrincipal = new Principal();
}
