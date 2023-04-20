import 'package:flutter/material.dart';
import 'package:project_agiles/models/ruta_model.dart';

class RutaFormProvider with ChangeNotifier {

  final key = GlobalKey<FormState>();

  Ruta ruta = Ruta(
    cupo: '',
    id: '',
    idUser: '',
    llegada: '',
    nombre: '',
    placa: '',
    salida: '',
    telefono: '',
    estado: true
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