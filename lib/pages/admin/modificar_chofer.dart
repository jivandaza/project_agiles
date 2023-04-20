import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_agiles/models/user_model.dart';
import 'package:project_agiles/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../../provider/user_form_provider.dart';
import '../../services/user_service.dart';
import '../../widgets/button_blue.dart';
import '../../widgets/text_input.dart';

class ModificarChofer extends StatelessWidget {
  const ModificarChofer({super.key, required this.chofer});

  final Users chofer;

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
          child: _Form(chofer: chofer,)
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({
    Key? key, required this.chofer,
  }) : super(key: key);

  final Users chofer;

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

    return Form(
      key: userForm.key,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: userForm.validForm,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: size.height * 0.05),
            alignment: Alignment.center,
            child: const Text('Modificar Chofer',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.blue),),
          ),
          CardData(size: size, titulo: widget.chofer.correo),
          CardData(size: size, titulo: widget.chofer.identificacion),
          CardData(size: size, titulo: widget.chofer.nombre),
          CustomTextFormInt(
            controller: phoneCtrl,
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            label: 'Celular',
            placeholder: 'Celular',
            onChange: (value) =>  widget.chofer.telefono = value,
            validator: (value) {
              return value!.length != 10 ? 'Numero de celular invalido' : null;
            },
          ),
          CustomTextForm(
            controller: placaCtrl,
            icon: Icons.directions_car_outlined,
            keyboardType: TextInputType.text,
            label: 'Placa del Carro',
            placeholder: 'Placa',
            onChange: (value) => widget.chofer.placa = value,
            validator: (value) {
              return value!.length != 7 ? 'Placa invalida' : null;
            },
          ),
          ButtonBlue(label: 'Agregar',
            onPressed: userForm.isValid ? () async{
              FocusManager.instance.primaryFocus?.unfocus();
              print(widget.chofer.toJson());
              final userService = Provider.of<UserService>(context, listen: false);
              await userService.updateUser(widget.chofer);
              Get.offAll(HomeAdmin(size: size,));
              QuickAlert.show(context: context,
                type: QuickAlertType.confirm,
                title: 'OK',
                text: 'Chofer modificado exitosamente'
              );
            }: null
          )
        ],
      ),
    );
  }
}

class CardData extends StatelessWidget {
  const CardData({
    Key? key,
    required this.size,
    required this.titulo,
  }) : super(key: key);

  final Size size;
  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.7,
      height: size.height * 0.06,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8)
      ),
      child: Center(child: Text(titulo, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      )),
    );
  }
}