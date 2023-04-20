
import 'dart:convert';

class Users {
    Users({
      required this.id,
      required this.correo,
      required this.identificacion,
      required this.nombre,
      required this.telefono,
      required this.placa,
      required this.tipo,
      required this.ruta,
      this.password,
    });

    String id;
    String correo;
    String identificacion;
    String nombre;
    String telefono;
    String placa;
    String tipo;
    bool ruta;
    String? password;

    factory Users.fromJson(String str) => Users.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Users.fromMap(Map<String, dynamic> json) => Users(
        id: json["id"],
        correo: json["correo"],
        identificacion: json["identificacion"],
        nombre: json["nombre"],
        telefono: json["telefono"],
        password: json["password"],
        placa: json["placa"],
        tipo: json["tipo"],
        ruta: json["ruta"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "correo": correo,
        "identificacion": identificacion,
        "nombre": nombre,
        "telefono": telefono,
        "password": password,
        "placa": placa,
        "tipo": tipo,
        "ruta": ruta,
    };
}
