import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_agiles/pages/home_page.dart';
import 'package:project_agiles/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../provider/login_provider.dart';
import '../services/user_service.dart';
import '../widgets/button_blue.dart';
import '../widgets/text_input.dart';
  

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});


  @override
  Widget build(BuildContext context) {

  final size = MediaQuery.of(context).size;

  return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: SizedBox(
            height: size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.5,
                  child: const Image(image: AssetImage('assets/logo.png'))
                ),
                ChangeNotifierProvider(
                  create: ( _ ) => LoginForm(),
                  child: _Form()
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}


class _Form extends StatefulWidget {

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginForm>(context);

    return Form(
      key: loginForm.key,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: loginForm.validForm,
      child: Column(
        children: [
          CustomTextForm(
            controller: emailCtrl,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            label: 'Correo',
            placeholder: 'Correo',
            onChange: (value) => loginForm.email = value,
            validator: (value)  {
              const pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp  = RegExp(pattern);
              return regExp.hasMatch(value ?? '')
              ? null
              : 'no es un correo válido';
            },
          ),
          CustomTextForm(
            controller: passwordCtrl,
            icon: Icons.lock_outline,
            keyboardType: TextInputType.emailAddress,
            label: 'Contraseña',
            placeholder: 'Contraseña',
            onChange: (value) => loginForm.password = value,
            validator: (value) {
               return value!.length < 6 ? 'No puede contener menos de 6 caracteres' : null;
            },
            isPassword: true,
          ),
          ButtonBlue(
            label: 'Ingresar',
            onPressed: loginForm.isValid ? () async {
              FocusManager.instance.primaryFocus?.unfocus();
              final authService = Provider.of<AuthService>(context, listen: false);
              final userService = Provider.of<UserService>(context, listen: false);
              bool? paso = await authService.login(loginForm.email, loginForm.password);
              print('respuesta: ${paso}');
              if(paso!){
                userService.user = authService.user;
                Get.offAll(HomePage(user: authService.user,));
              } else {
                  QuickAlert.show(context: context,
                  type: QuickAlertType.error,
                  title: 'Error',
                  text: authService.mensaje
                );
              }
            } : null
          ),
        ],
      ),
    );
  }
}
