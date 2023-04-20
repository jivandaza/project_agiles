import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_agiles/models/ruta_model.dart';


class RutaService extends ChangeNotifier {

  Ruta _ruta = Ruta(id: '', idUser: '', nombre: '', telefono: '', placa: '', cupo: '', salida: '', llegada: '', estado: true);

  Ruta get ruta {
    return _ruta;
  }

  set ruta(Ruta u){
    _ruta = u;
    notifyListeners();
  }

  Future <bool> createRuta(Ruta data) async {
    try{
      final docRuta = FirebaseFirestore.instance.collection('ruta').doc();
      data.id = docRuta.id;
      await docRuta.set(data.toMap());
      ruta = data;
    }catch(e){
      print(e);
      return false;
    }
    return true;
  }

  Future <bool> getRutaChofer(String id) async{
    
    final docUser = FirebaseFirestore.instance.collection('ruta')
    .where('id_user', isEqualTo: id)
    .where('estado', isEqualTo: true);
    final snapshot = await docUser.get();
    List<Ruta> rutas = [];
    for(var doc in snapshot.docs){
      rutas.add(Ruta.fromMap(doc.data()));
    }
    print(rutas.length);
    ruta = rutas[0];
    notifyListeners();
    return true;
  }

  Future <List<Ruta>> getRutasDisponibles() async{
    
    final docUser = FirebaseFirestore.instance.collection('ruta')
    .where('estado', isEqualTo: true);
    final snapshot = await docUser.get();
    List<Ruta> rutas = [];
    for(var doc in snapshot.docs){
      rutas.add(Ruta.fromMap(doc.data()));
    }
    print(rutas.length);
    notifyListeners();
    return rutas;
  }


  Future updateEstadoRuta(Ruta data) async {
    FirebaseFirestore.instance.collection('ruta').doc(data.id).set(data.toMap());
    ruta = data;
    notifyListeners();
  }
}

