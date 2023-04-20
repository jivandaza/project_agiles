import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class ChoferService extends ChangeNotifier {
  List<Users> users = [];

  ChoferService(){
    listaChoferes();
  }

  Future<List<Users>>  listaChoferes() async{ 
    users = [];
    final docUser = FirebaseFirestore.instance.collection('user')
    .where('tipo', isEqualTo: 'user');
    final snapshot = await docUser.get();
    for( var doc in snapshot.docs){
      users.add(Users.fromMap(doc.data()));
    }
    return users;
  }
}
