import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextForm extends StatelessWidget {

  final TextEditingController controller;
  final String label;
  final Function(String value ) onChange; 
  final String? Function(String? value ) validator; 
  final IconData icon;
  final String placeholder;
  final bool isPassword;
  final TextInputType keyboardType;

  const CustomTextForm({super.key, 
    required this.controller, 
    required this.label, 
    required this.onChange, 
    required this.validator, 
    required this.icon, 
    required this.placeholder, 
    this.isPassword = false, required this.keyboardType
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.height * 0.05, vertical: size.width * 0.025),
      padding: EdgeInsets.symmetric(horizontal: size.height * 0.012),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(10),
      // ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          icon: Icon(icon),
          hintText: placeholder,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color: Colors.blue
            )
          ),
        ),
        onChanged: onChange,
        validator: validator,
      ),
    );
  }
}

class CustomTextFormInt extends StatelessWidget {

  final TextEditingController controller;
  final String label;
  final Function(String value ) onChange; 
  final String? Function(String? value ) validator; 
  final IconData icon;
  final String placeholder;
  final bool isPassword;
  final TextInputType keyboardType;

  const CustomTextFormInt({super.key, 
    required this.controller, 
    required this.label, 
    required this.onChange, 
    required this.validator, 
    required this.icon, 
    required this.placeholder, 
    this.isPassword = false, required this.keyboardType
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.height * 0.05, vertical: size.width * 0.025),
      padding: EdgeInsets.symmetric(horizontal: size.height * 0.012),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(10),
      // ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          labelText: label,
          icon: Icon(icon),
          hintText: placeholder,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color: Colors.blue
            )
          ),
        ),
        onChanged: onChange,
        validator: validator,
      ),
    );
  }
}