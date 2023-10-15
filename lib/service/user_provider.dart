


// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:crud_sheety/models/model.dart';
import 'package:crud_sheety/utils/api_key.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class RecursosProvider extends ChangeNotifier {
  final String _baseUrl = 'api.sheety.co';

 //Lista de Usuarios: al hacer la peticion get, todos los susarios se cargan en esta lista
  List<User> recursoList = [];
  late User selectedUser;

  File? newPictureFile; //aqui almacenamos la imagen

  bool isaving = false;

  //Metodo CONTRUCTOR.
  RecursosProvider() {
    print('Recursos Usuario Inicializado');
    getRecursosProvider();
  }

  //get: Traer todos lo Usuarios
  getRecursosProvider() async {
    var url = Uri.https(_baseUrl, '$pathKey/user');
    final response = await http.get(url);
    final decodeData = UsuarioModel.fromJson(response.body);

    recursoList = decodeData.user;
    notifyListeners();
  }

  //guardar cambios
  Future saveOrCreateProduct(User user) async {
    isaving = true;
    notifyListeners();

    if (user.id == null) {
      //es nesesario crear usuario
      await createUSer(user);
    } else {
      await updateUSer(user);
    }

    isaving = false;
    notifyListeners();
  }

  Future<String> updateUSer(User user) async {
    try{
    var url = Uri.https(_baseUrl, '$pathKey/user/${user.id}');
    final response = await http.put(url,
        headers: {
          "Content-Type": "application/json",
        },
        body:
            // user.toJson()
            json.encode({
          "user": {
            "nombreCompleto": user.nombreCompleto,
            "apellido": user.apellido,
            "genero": user.genero,
            "role": user.role,
            "dni": user.dni,
            "password": user.password,
            "cargo": user.cargo,
            "direccion": user.direccion,
            "telefono": user.telefono,
            "correo": user.correo,
            "estatus": user.estatus,
            "calification": user.calification,
            "image": user.image,
          }
        }));
        if (response.statusCode == 200) {
            // ignore: unused_local_variable
            final decodeData = response.body;
            //ACTULIZAR EL LISTADO DE PRODUCTOS
            final index = recursoList.indexWhere((element) => element.id == user.id);
            recursoList[index] = user;
            return '${user.id}';
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

  Future<String> createUSer(User user) async {
  try {
    var url = Uri.https(_baseUrl, '$pathKey/user');
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        "user": {
          "nombreCompleto": user.nombreCompleto,
          "apellido": user.apellido,
          "genero": user.genero,
          "role": user.role,
          "dni": user.dni,
          "password": user.password,
          "cargo": user.cargo,
          "direccion": user.direccion,
          "telefono": user.telefono,
          "correo": user.correo,
          "estatus": user.estatus,
          "calification": user.calification,
          "image": user.image,
        }
      }),
    );

    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body);
      user.id = decodeData["user"]["id"];
      recursoList.add(user);
      return '${user.id}';
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

  //CAMBIAR LA IMAGEN EN LA VISTA PREVIA
  void updateSelectedUserImage(String paths) {
    selectedUser.image = paths;
    newPictureFile = File.fromUri(Uri(path: paths)); //buscar archivo, y va crear el archivo

    notifyListeners();
  }

  
    Future<void> deleteUser(int userId) async {
    try {
      final url = Uri.https(_baseUrl, '$pathKey/user/$userId');
      final response = await http.delete(url);
      if (response.statusCode == 202) {
        // La solicitud fue aceptada, pero no tenemos información de respuesta.
        // Así que simplemente eliminamos el usuario localmente.
        final removedUserId = userId;
        recursoList.removeWhere((user) => user.id == removedUserId);
        print('Usuario eliminado con éxito: $userId ${response.statusCode }');
      } else if (response.statusCode == 204) {
        // La solicitud fue exitosa y no hay contenido para devolver, lo que significa
        // que el usuario se eliminó correctamente en el servidor. Eliminamos el usuario
        // localmente.
        final removedUserId = userId;
        recursoList.removeWhere((user) => user.id == removedUserId);
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


  // Future<String?> uploadImage() async {
  //   if (newPictureFile == null) return null;
  //   isaving = true;

  //   notifyListeners();

  //   final url = Uri.parse('https://api.cloudinary.com/v1_1/dw2vwrqem/image/upload?upload_preset=y8etxxjt');
  //   final imageUploadrequest = http.MultipartRequest('POST', url);

  //   final file =
  //       await http.MultipartFile.fromPath('file', newPictureFile!.path);

  //   imageUploadrequest.files.add(file);

  //   final streamResponse = await imageUploadrequest.send();

  //   final response = await http.Response.fromStream(streamResponse);

  //   if (response.statusCode != 200 && response.statusCode != 201) {
  //     print('Algo salio mal');
  //     print(response.body);
  //     return null;
  //   }

  //   newPictureFile = null;

  //   final decodeData = json.decode(response.body);

  //   return decodeData['secure_url'];
  // }


Future<String?> uploadImage() async {
  if (newPictureFile == null) return null;

  final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/dw2vwrqem/image/upload?upload_preset=y8etxxjt');

  try {
    final request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('file', newPictureFile!.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final responseBody = response.body;
      final decodedData = json.decode(responseBody);
      return decodedData['secure_url'];
    } else {
      print('Error al subir la imagen: ${response.statusCode}');
    }
  } catch (error) {
    print('Error al subir la imagen: $error');
  } finally {
    newPictureFile = null;
  }

  return null;
}


}
