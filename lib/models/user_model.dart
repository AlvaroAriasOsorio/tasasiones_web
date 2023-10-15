
import 'dart:convert';

class UsuarioModel {
    UsuarioModel({
      required  this.user,
    });

    List<User> user;

    factory UsuarioModel.fromJson(String str) => UsuarioModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UsuarioModel.fromMap(Map<String, dynamic> json) => UsuarioModel(
        user: List<User>.from(json["user"].map((x) => User.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "user": List<dynamic>.from(user.map((x) => x.toMap())),
    };
}

class User {
    User({
      required  this.nombreCompleto,
       required this.password,
       required this.estatus,
       required this.calification,
       required this.dni,
       required this.direccion,
       required this.telefono,
       required this.role,
       required this.image,
       required this.cargo,
       required this.correo,
       required this.genero,
       required this.apellido,
        this.id,
    });

    String nombreCompleto;
    String password;
    bool estatus;
    int calification;
    int dni;
    String direccion;
    int telefono;
    String role;
    String image;
    String cargo;
    String correo;
    String genero;
    String apellido;
    int? id;

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        nombreCompleto: json["nombreCompleto"],
        password: json["password"],
        estatus: json["estatus"],
        calification: json["calification"].toInt() ?? 0,
        dni: json["dni"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        role: json["role"],
        image: json["image"]?? 'https://i.pinimg.com/564x/c5/76/f5/c576f530f067842936c3a4b9b2a93b54.jpg',
        cargo: json["cargo"],
        correo: json["correo"],
        genero: json["genero"],
        id: json["id"], 
        apellido: json["apellido"],
    );

    Map<String, dynamic> toMap() => {
        "nombreCompleto": nombreCompleto,
        "password": password,
        "estatus": estatus,
        "calification": calification,
        "dni": dni,
        "direccion": direccion,
        "telefono": telefono,
        "role": role,
        "image": image,
        "cargo": cargo,
        "correo": correo,
        "genero": genero,
        "apellido": apellido,
        "id": id,
    };


    User copy() => User(
        nombreCompleto: nombreCompleto,
        password: password,
        estatus: estatus,
        calification: calification,
        dni: dni,
        direccion: direccion,
        image: image,
        telefono: telefono,
        role: role,
        id: id,
        cargo: cargo, 
        correo: correo, 
        genero: genero,
        apellido:apellido
    );
}

