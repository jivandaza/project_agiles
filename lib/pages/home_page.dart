import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_agiles/models/user_model.dart';
import 'package:project_agiles/pages/admin/agregar_chofer.dart';
import 'package:project_agiles/pages/admin/lista_mod_choferes.dart';
import 'package:project_agiles/pages/chofer/chofer_page.dart';
import 'package:project_agiles/pages/inicio_page.dart';
import 'package:project_agiles/pages/rutas_page.dart';
import 'package:project_agiles/services/chofer_service.dart';
import 'package:provider/provider.dart';

import '../services/ruta_servive.dart';
import '../widgets/cards.dart';
import 'admin/lista.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.user});

  final Users user;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    print(user.tipo);
    final rutaService = Provider.of<RutaService>(context, listen: false);

     if(user.tipo == 'admin'){
      return HomeAdmin(size: size);
     }else{
      void traerDataRuta() async{
        if(user.ruta) {
          await rutaService.getRutaChofer(user.id);
        }
      }
      traerDataRuta();
      return const ChoferPage();
     } 
  }
}

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COOTRANCZNORTE'),
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
      body: Container(
        margin: EdgeInsets.only(top: size.height * 0.05),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardInicio(navegator: () => Get.to(AgregarChofer()), image: 'assets/agregarChofer.png', titulo: 'Agregar chofer', ancho: 0.4),
                SizedBox(width: size.width * 0.07),
                CardInicio(navegator: () async{
                   final choferService = Provider.of<ChoferService>(context, listen: false);
                  await choferService.listaChoferes();
                  Get.to(ListaModChoferes(choferes: choferService.users,));
                }, image: 'assets/modificarChofer.png', titulo: 'Modificar', ancho: 0.4,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardInicio(navegator:  () async{
                  final choferService = Provider.of<ChoferService>(context, listen: false);
                  await choferService.listaChoferes();
                  Get.to(ListarChofer(choferes: choferService.users,));
                },
                image: 'assets/listaChofer.png', titulo: 'Lista de choferes', ancho: 0.4),
                SizedBox(width: size.width * 0.07),
                CardInicio(
                  navegator: () async {
                    final rutaService = Provider.of<RutaService>(context, listen: false);
                    final ruta = await rutaService.getRutasDisponibles();
                    ruta.isEmpty ? 
                    Get.to(RutaPage()) : Get.to(RutaPage(rutas: ruta,));
                  },
                  image: 'assets/choferTurno.png', titulo: 'Choferes de turno', ancho: 0.4,),
              ],
            ),
          ],
        ),
      )
    );
  }
}