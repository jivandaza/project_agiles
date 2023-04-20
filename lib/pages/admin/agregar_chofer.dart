import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_agiles/provider/user_form_provider.dart';
import 'package:project_agiles/services/user_service.dart';
import 'package:project_agiles/widgets/button_blue.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../../widgets/text_input.dart';

class AgregarChofer extends StatefulWidget {
  const AgregarChofer({super.key});

  @override
  State<AgregarChofer> createState() => _AgregarChoferState();
}

class _AgregarChoferState extends State<AgregarChofer> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_outlined, color: Colors.black, size: 30,)),
      ),
      body: SingleChildScrollView(
        child: ChangeNotifierProvider(
          create: ( _ ) => UserFormProvider(),
          child: _Form()
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({
    Key? key,
  }) : super(key: key);

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final idCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final placaCtrl = TextEditingController();
  String password = '';

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final userForm = Provider.of<UserFormProvider>(context);
    final user = userForm.user;

    return Form(
      key: userForm.key,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: userForm.validForm,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: size.height * 0.05),
            alignment: Alignment.center,
            child: const Text('Agregar Chofer',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.blue),),
          ),
          CustomTextForm(
            controller: emailCtrl,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            label: 'Correo',
            placeholder: 'Correo',
            onChange: (value) => user.correo = value,
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
            onChange: (value) => user.password = value,
            validator: (value) {
               return value!.length < 6 ? 'No puede contener menos de 6 caracteres' : null;
            },
            isPassword: true,
          ),
          CustomTextFormInt(
            controller: idCtrl,
            icon: Icons.account_box_outlined,
            keyboardType: TextInputType.number,
            label: 'Identificacion del Chofer',
            placeholder: '100******',
            onChange: (value) => user.identificacion = value,
            validator: (value) {
              if(value!.length < 7 || value.length > 10 ){
                return 'Identificación debe tener de 7 a 10 caracteres';
              }
              return null;
            },
          ),
          CustomTextForm(
            controller: nameCtrl,
            icon: Icons.person_outline,
            keyboardType: TextInputType.name,
            label: 'Nombre del Chofer',
            placeholder: 'Nombre',
            onChange: (value) => user.nombre = value,
            validator: (value) {
              return value!.length < 4 ? 'No puede contener menos de 4 caracteres' : null;
            },
          ),
          CustomTextFormInt(
            controller: phoneCtrl,
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            label: 'Celular',
            placeholder: 'Celular',
            onChange: (value) => user.telefono = value,
            validator: (value) {
              return value!.length != 10 ? 'Numero de celular invalido' : null;
            },
          ),
          CustomTextForm(
            controller: placaCtrl,
            icon: Icons.directions_car_outlined,
            keyboardType: TextInputType.text,
            label: 'Placa del Carro',
            placeholder: 'exa-23d',
            onChange: (value) => user.placa = value,
            validator: (value) {
             if(value!.length==7){
               const pattern=r'^[a-zA-Z0-9]+-[a-zA-Z0-9]';
                RegExp regExp  = RegExp(pattern);
              return regExp.hasMatch(value ?? '')
              ? null
              : 'no es una placa válida';}
              return value.length != 7 ? 'debe contener 7 caracteres' : null;
            },
          ),
          ButtonBlue(label: 'Agregar',
            onPressed: userForm.isValid ? () async{
              FocusManager.instance.primaryFocus?.unfocus();
              final userService = Provider.of<UserService>(context, listen: false);
              bool? paso = await userService.createUser(user);
             // paso! ? Get.back():
              print(paso);
              
              if(paso!){
              Get.back();
                 QuickAlert.show(context: context,
                type: QuickAlertType.success,
                title: 'Registro Exitoso',
                text: 'Chofer Agregado');
              } else {
              
              QuickAlert.show(context: context,
                type: QuickAlertType.error,
                title: 'Error',
                text: userService.mensaje
              );
            }
            }: null
          )
        ],
      ),
    );
  }
}