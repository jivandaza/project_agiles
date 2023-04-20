import 'dart:convert';

class Ruta {
    Ruta({
      required this.id,
      required this.idUser,
      required this.nombre,
      required this.telefono,
      required this.placa,
      required this.cupo,
      required this.salida,
      required this.llegada,
      required this.estado,
    });

    String id;
    String idUser;
    String nombre;
    String telefono;
    String placa;
    String cupo;
    String salida;
    String llegada;
    bool estado;

    factory Ruta.fromJson(String str) => Ruta.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Ruta.fromMap(Map<String, dynamic> json) => Ruta(
        id: json["id"],
        idUser: json["id_user"],
        nombre: json["nombre"],
        telefono: json["telefono"],
        placa: json["placa"],
        cupo: json["cupo"],
        salida: json["salida"],
        llegada: json["llegada"],
        estado: json["estado"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "id_user": idUser,
        "nombre": nombre,
        "telefono": telefono,
        "placa": placa,
        "cupo": cupo,
        "salida": salida,
        "llegada": llegada,
        "estado": estado,
    };
}
