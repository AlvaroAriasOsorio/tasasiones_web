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
    String mes;
    int bt;
    String tipoBanca;
    String nDocumento;
    String funcionarioBanco;

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
        required this.mes,
        required this.bt,
        required this.tipoBanca,
        required this.nDocumento,
        required this.funcionarioBanco,
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
        mes: json["mes"],
        bt: json["bt"],
        tipoBanca: json["tipoBanca"],
        nDocumento: json["n°Documento"],
        funcionarioBanco: json["funcionarioBanco"],
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
        "mes": mes,
        "bt": bt,
        "tipoBanca": tipoBanca,
        "n°Documento": nDocumento,
        "funcionarioBanco": funcionarioBanco,
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
      programarFechaVisita: programarFechaVisita,
      mes: mes,
      bt: bt,
      tipoBanca: tipoBanca,
      nDocumento: nDocumento,
      funcionarioBanco: funcionarioBanco,
      );
}
