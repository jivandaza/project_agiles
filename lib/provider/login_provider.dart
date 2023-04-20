import 'package:flutter/material.dart';

class LoginForm with ChangeNotifier {

  final key = GlobalKey<FormState>();

  String password = '';
  String email = '';


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading (bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isValid = false;
  bool get isValid => _isValid;
  set isValid (bool value) {
    _isValid = value;
    notifyListeners();
  }


  bool isValidForm(){

    print('$email - $password');
    
    print(key.currentState?.validate());

    return key.currentState?.validate() ?? false;
  }

  validForm() {
    print('Válido ${key.currentState?.validate()}');
    isValid = key.currentState?.validate() ?? false;
  }
  
}