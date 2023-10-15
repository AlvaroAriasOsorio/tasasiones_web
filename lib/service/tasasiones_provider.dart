
import 'dart:convert';
import 'dart:io';

// import 'package:crud_sheety/models/model.dart';
import 'package:crud_sheety/models/tasasiones_model.dart';
import 'package:crud_sheety/utils/api_key.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class TasasionesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.sheety.co';

 //Lista de Usuarios: al hacer la peticion get, todos los susarios se cargan en esta lista
  List<Tasasione> tasasiones = [];
  late Tasasione selectedUser;

  File? newPictureFile; //aqui almacenamos la imagen

  bool isaving = false;

  //Metodo CONTRUCTOR.
  TasasionesProvider() {
    print('Tasasiones  Inicializado');
    getRecursosProvider();
  }

  //get: Traer todos los Usuarios
Future<void> getRecursosProvider() async {
  try {
    var url = Uri.https(_baseUrl, '$pathKey/tasasiones');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decodeData = TasasionesModel.fromJson(response.body);
      // print(tasasiones[0].cliente);
      tasasiones = decodeData.tasasiones;
      notifyListeners();
    } else {
      // Aquí puedes manejar la respuesta en caso de un código de estado diferente a 200
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    // Captura cualquier excepción que ocurra durante la solicitud HTTP
    print('Error al realizar la solicitud HTTP: $e');
  }
}


  //guardar cambios
  Future saveOrCreateProduct(Tasasione e) async {
    isaving = true;
    notifyListeners();

    if (e.id == null) {
      //es nesesario crear usuario
      await createUSer(e);
    } else {
      await updateUSer(e);
    }

    isaving = false;
    notifyListeners();
  }

  Future<String> updateUSer(Tasasione e) async {
    try{
    var url = Uri.https(_baseUrl, '$pathKey/tasasiones/${e.id}');
    final response = await http.put(url,
        headers: {
          "Content-Type": "application/json",
        },
        body:
            // user.toJson()
            json.encode({
          "tasasione": {
            "idBanca": e.idBanca,
            "cliente": e.cliente,
            "solicitante": e.solicitante,
            "propietario": e.propietario,
            "ubicacion": e.ubicacion,
            "valorDelM2DeTerreno/dpto": e.valorDelM2DeTerrenoDpto,
            "valorComercial": e.valorComercial,
            "valorRealizacion": e.valorRealizacion,
            "ubicacionMaps": e.ubicacionMaps,
            "linkInformepdf": e.linkInformepdf,
            "estatus": e.estatus,
            "programarFechaVisita": e.programarFechaVisita,
            // "id": e.id,
          }
        }));
        if (response.statusCode == 200) {
            // ignore: unused_local_variable
            final decodeData = response.body;
            //ACTULIZAR EL LISTADO DE PRODUCTOS
            final index = tasasiones.indexWhere((element) => element.id == e.id);
            tasasiones[index] = e;
            return '${e.id}';
        } else {
            // Manejar errores si es necesario
          print("Error en la solicitud: ${response.statusCode}");
          return ''; // Devolver una cadena vacía en caso de error
        }
    }
    catch (error) {
       print('Error al crear el usuario: $error');
      return '';
    }
  }

  Future<String> createUSer(Tasasione e) async {
  try {
    var url = Uri.https(_baseUrl, '$pathKey/tasasiones');
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        "tasasione": {
            "idBanca": e.idBanca,
            "cliente": e.cliente,
            "solicitante": e.solicitante,
            "propietario": e.propietario,
            "ubicacion": e.ubicacion,
            "valorDelM2DeTerreno/dpto": e.valorDelM2DeTerrenoDpto,
            "valorComercial": e.valorComercial,
            "valorRealizacion": e.valorRealizacion,
            "ubicacionMaps": e.ubicacionMaps,
            "linkInformepdf": e.linkInformepdf,
            "estatus": e.estatus,
            "programarFechaVisita": e.programarFechaVisita,
            // "id": e.id,
        }
      }),
    );

    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body);
      e.id = decodeData["tasasione"]["id"];
      tasasiones.add(e);
      return '${e.id}';
    } else {
      // Manejar errores si es necesario
      print("Error en la solicitud: ${response.statusCode}");
      return ''; // Devolver una cadena vacía en caso de error
    }
  } catch (error) {
    // Manejar errores de conexión o cualquier otra excepción
    print('Error al crear el usuario: $error');
    return ''; // Devolver una cadena vacía en caso de error
  }
}

  
    Future<void> deleteUser(int userId) async {
    try {
      final url = Uri.https(_baseUrl, '$pathKey/tasasiones/$userId');
      final response = await http.delete(url);
      if (response.statusCode == 202) {
        // La solicitud fue aceptada, pero no tenemos información de respuesta.
        // Así que simplemente eliminamos el usuario localmente.
        final removedUserId = userId;
        tasasiones.removeWhere((user) => user.id == removedUserId);
        print('Usuario eliminado con éxito: $userId ${response.statusCode }');
      } else if (response.statusCode == 204) {
        // La solicitud fue exitosa y no hay contenido para devolver, lo que significa
        // que el usuario se eliminó correctamente en el servidor. Eliminamos el usuario
        // localmente.
        final removedUserId = userId;
        tasasiones.removeWhere((user) => user.id == removedUserId);
        print('Usuario eliminado con éxito: $userId ${response.statusCode}');
      } else {
        // Manejar errores si es necesario
        print('Error al eliminar el usuario: ${response.statusCode}');
      }
    } catch (error) {
      // Manejar errores de conexión o cualquier otra excepción
      print('Error al eliminar el usuario: $error');
    }
    notifyListeners();
  }

}
