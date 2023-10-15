import 'dart:convert';

class TasasionesModel {
    List<Tasasione> tasasiones;

    TasasionesModel({
        required this.tasasiones,
    });

    factory TasasionesModel.fromJson(String str) => TasasionesModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TasasionesModel.fromMap(Map<String, dynamic> json) => TasasionesModel(
        tasasiones: List<Tasasione>.from(json["tasasiones"].map((x) => Tasasione.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "tasasiones": List<dynamic>.from(tasasiones.map((x) => x.toMap())),
    };
}

class Tasasione {
    int? id;
    String idBanca;
    String cliente;
    String solicitante;
    String propietario;
    String ubicacion;
    int valorDelM2DeTerrenoDpto;
    int valorComercial;
    int valorRealizacion;
    String ubicacionMaps;
    String linkInformepdf;
    bool estatus;
    String programarFechaVisita;

    Tasasione({
        this.id,
        required this.idBanca,
        required this.cliente,
        required this.solicitante,
        required this.propietario,
        required this.ubicacion,
        required this.valorDelM2DeTerrenoDpto,
        required this.valorComercial,
        required this.valorRealizacion,
        required this.ubicacionMaps,
        required this.linkInformepdf,
        required dynamic estatus,
        required this.programarFechaVisita,
  }) : estatus = estatus is bool ? estatus : estatus.toLowerCase() == 'true';


    factory Tasasione.fromJson(String str) => Tasasione.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Tasasione.fromMap(Map<String, dynamic> json) => Tasasione(
        id: json["id"],
        idBanca: json["idBanca"],
        cliente: json["cliente"],
        solicitante: json["solicitante"],
        propietario: json["propietario"],
        ubicacion: json["ubicacion"],
        valorDelM2DeTerrenoDpto: json["valorDelM2DeTerreno/dpto"],
        valorComercial: json["valorComercial"],
        valorRealizacion: json["valorRealizacion"],
        ubicacionMaps: json["ubicacionMaps"],
        linkInformepdf: json["linkInformepdf"],
        estatus: json["estatus"] is bool
        ? json["estatus"]
        : json["estatus"].toString().toLowerCase() == 'true',
        programarFechaVisita:json["programarFechaVisita"], // Convierte la cadena a DateTime
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "idBanca": idBanca,
        "cliente": cliente,
        "solicitante": solicitante,
        "propietario": propietario,
        "ubicacion": ubicacion,
        "valorDelM2DeTerreno/dpto": valorDelM2DeTerrenoDpto,
        "valorComercial": valorComercial,
        "valorRealizacion": valorRealizacion,
        "ubicacionMaps": ubicacionMaps,
        "linkInformepdf": linkInformepdf,
        "estatus": estatus,
        "programarFechaVisita": programarFechaVisita,
    };
    Tasasione copy()=> Tasasione(
      id: id, 
      idBanca: idBanca, 
      cliente: cliente, 
      solicitante: solicitante, 
      propietario: propietario, 
      ubicacion: ubicacion, 
      valorDelM2DeTerrenoDpto: valorDelM2DeTerrenoDpto, 
      valorComercial: valorComercial, 
      valorRealizacion: valorRealizacion, 
      ubicacionMaps: ubicacionMaps, 
      linkInformepdf: linkInformepdf, 
      estatus: estatus, 
      programarFechaVisita: programarFechaVisita
      );
}
