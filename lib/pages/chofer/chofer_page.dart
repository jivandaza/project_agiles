import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_agiles/provider/ruta_form_provider.dart';
import 'package:project_agiles/services/ruta_servive.dart';
import 'package:project_agiles/services/user_service.dart';
import 'package:project_agiles/widgets/button_blue.dart';
import 'package:project_agiles/widgets/card_ruta.dart';
import 'package:project_agiles/widgets/dropdow.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../widgets/text_input.dart';
import '../inicio_page.dart';

class ChoferPage extends StatefulWidget {
  const ChoferPage({super.key}); 
  @override
  State<ChoferPage> createState() => _ChoferPageState();
}

class _ChoferPageState extends State<ChoferPage> {
  @override
  Widget build(BuildContext context) {
    
    final userService = Provider.of<UserService>(context, listen: false);
    final user = userService.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(user.nombre),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Get.offAll(const InicioPage());
              },
              child: const Icon(Icons.logout_outlined ,color: Colors.red, size: 30,),
            ),
          )
        ],
      ),
      body:  userService.user.ruta ? RutaExistente() 
      : ChangeNotifierProvider(
        create: ( _ ) => RutaFormProvider(),
        child: FormChofer(user: user,)
      )
    );
  }
}

class RutaExistente extends StatelessWidget {
  const RutaExistente({super.key});

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CardRutaChofer(),
          ButtonBlue(label: 'Finalizar Ruta', onPressed: () async{
            final rutaService = Provider.of<RutaService>(context, listen: false);
            final ruta = rutaService.ruta; 
            final userService = Provider.of<UserService>(context, listen: false);
            final user = userService.user;
            print(ruta.nombre);
            user.ruta = false;
            ruta.estado = false;
            await userService.updateUser(user);
            await rutaService.updateEstadoRuta(ruta);
            Get.offAll(ChoferPage());
          },)
        ],
      ),
    );
  }
}

class FormChofer extends StatefulWidget {
  const FormChofer({super.key, required this.user});

  final Users user;
  @override
  State<FormChofer> createState() => _FormChoferState();
}

class _FormChoferState extends State<FormChofer> {

  final puestoCtrl = TextEditingController();
  String destino = '';
  String salida = '';
  String puesto = '';


  @override
  Widget build(BuildContext context) {

    List lugar = ['Atanquez', 'Valledupar'];
    final size = MediaQuery.of(context).size;
    final rutaForm = Provider.of<RutaFormProvider>(context);
    final ruta = rutaForm.ruta;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: rutaForm.key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: rutaForm.validForm,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.1 ),
            height: size.height * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Dropdown(data: lugar, tipo: 'Lugar de salida', 
                  onChange:(value) {
                    setState(() {
                      salida = value!;
                      (value == 'Atanquez') ? destino = 'Valledupar' : destino = 'Atanquez';
                      print('destino: ${destino}');
                      print(salida);
                    }); 
                  },
                  validator: (value) {
                   return salida == '' ? 'Seleccione lugar de salida' : null;
                  },
                ),
                const SizedBox(height: 10,),
                const Text('Lugar de llegada', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                const SizedBox(height: 8,),
                Container(
                  width: double.infinity,
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: (destino == '') ? null
                    : Center(child: Text(destino, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)),
                ),
                const SizedBox(height: 15,),
                CustomTextFormInt(
                  controller: puestoCtrl,
                  icon: Icons.directions_bus_outlined,
                  keyboardType: TextInputType.number,
                  label: 'Cupos',
                  placeholder: 'Cantidad de cupos',
                  onChange: (value) => ruta.cupo = value,
                  validator: (value) {
                    if(value! != ''){
                      final parse = int.parse(value);
                      print(parse);
                      return parse <= 4 && parse > 0 ? null : '1 a 4 Cupos permitido';
                    }
                    return value.isEmpty ? 'Agregar Cupos': null;
                  },
                ),
                ButtonBlue(label: 'Agregar ruta', onPressed: rutaForm.isValid ? () async{
                  FocusManager.instance.primaryFocus?.unfocus();
                  ruta.idUser = widget.user.id;
                  ruta.llegada = destino;
                  ruta.salida = salida;
                  ruta.placa = widget.user.placa;
                  ruta.nombre = widget.user.nombre;
                  ruta.telefono = widget.user.telefono;
                  final rutaService = Provider.of<RutaService>(context, listen: false);
                  final userService = Provider.of<UserService>(context, listen: false);
                  bool paso = await rutaService.createRuta(ruta);
                  print(paso);
                  if(paso){
                    widget.user.ruta = true;
                    print('actualizar comienzo');
                    await userService.updateUser(widget.user);
                    Get.offAll(ChoferPage());
                  }else print('no paso');
                }: null
              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}