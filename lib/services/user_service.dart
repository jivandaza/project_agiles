import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_agiles/models/user_model.dart';


class UserService with ChangeNotifier{

  String mensaje = '';
  late Users _user;

  Users get user {
    return _user;
  }

  set user(Users u){
    _user = u;
    notifyListeners();
  }

  Future <bool?> createUser( Users user) async {

    bool? paso = await userAuth(user.correo, user.password!);
    if(paso) {
      try{
        final docUser = FirebaseFirestore.instance.collection('user').doc();
        user.id = docUser.id;
        await docUser.set(user.toMap());
      }catch(e){
        print(e);
        return false;
      }
    }else{
      return false;
    }
    return true;
  }


  Future<Users> userByEmail(String email) async{

    final docUser = FirebaseFirestore.instance.collection('user')
    .where('correo', isEqualTo: email);
    final snapshot = await docUser.get();
    List<Users> users = [];
    for( var doc in snapshot.docs){
      users.add(Users.fromMap(doc.data()));
    }
    user = users[0];
    print(users[0].correo);
    return users[0];
  }

  Future <bool> userAuth(String email, String password) async {
    try {
      final credencial = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
    } on FirebaseAuthException catch (e){
      if(e.code == 'weak-password') {
        mensaje = 'La contraseña proporcionada es demasiado débil.';
      } else if (e.code == 'email-already-in-use') {
        mensaje = 'La cuenta ya existe para ese correo electrónico.';
      }else{
        if(e.code=='unknown'){
          mensaje ='no';
        }
      }
      return false;
    }
    return true;
  }
  
  Future updateUser(Users usuario) async {
    print(usuario.id);
    print(user.correo);
    FirebaseFirestore.instance.collection('user').doc(usuario.id).set(usuario.toMap());
    user = usuario;
    notifyListeners();
  }

  Future <bool> deleteUser(Users data) async {
    final doc = FirebaseFirestore.instance.collection('user').doc(data.id);
    await doc.delete().then(
      (value) => print('Document deleted'),
      onError: (e) {
       print('Error: $e');
       return false;
      } 
    );
    return true;
  }
  
    
}