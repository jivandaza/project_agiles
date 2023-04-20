import 'package:flutter/material.dart';
import 'package:project_agiles/models/user_model.dart';

class UserFormProvider with ChangeNotifier {

  final key = GlobalKey<FormState>();

  Users user = Users(
    correo: '',
    id: '',
    identificacion: '',
    nombre: '',
    placa: '',
    telefono: '',
    ruta: false,
    tipo: 'user',
  );


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
    print(key.currentState?.validate());
    return key.currentState?.validate() ?? false;
  }

  validForm() {
    print('Válido ${key.currentState?.validate()}');
    isValid = key.currentState?.validate() ?? false;
  }
  
}
