import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_agiles/models/user_model.dart';
import 'package:project_agiles/services/user_service.dart';

class AuthService extends ChangeNotifier {

  String mensaje = '';
  late Users user;
  final userService = UserService();

  Future <bool?> login(String email, String password) async {
    try {
      final credencial = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      final userCredencial = credencial.user;
      print('Credecial user: ${userCredencial}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        mensaje = 'No existe un usuario con este correo';
      } else if (e.code == 'wrong-password') {
        mensaje = 'contraseña incorrecta';
      }
      return false;
    }
    user = await userService.userByEmail(email);
      
    return true;
  }

  Future deleteUser(String email, String password) async {

    final credencial = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final userCredencial = credencial.user;
    await userCredencial?.delete();
    print('elimino');
  }

}