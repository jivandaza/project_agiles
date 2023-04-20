import 'package:flutter/material.dart';
import 'package:project_agiles/pages/rutas_page.dart';
import 'package:project_agiles/services/ruta_servive.dart';
import 'package:provider/provider.dart';

class CardRutaChofer extends StatelessWidget {
  const CardRutaChofer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final rutaService = Provider.of<RutaService>(context);
    final ruta = rutaService.ruta;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: size.height * 0.01),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: size.height * 0.012),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
         boxShadow: const[
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 5),
            blurRadius: 5
          )
        ]
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: size.width * 0.15,
                child: const Image(image: AssetImage('assets/destino.png')),
              ),
              const SizedBox(width: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.grey[700],),
                      Text('${ruta.salida} - ${ruta.llegada}', style: const TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  const SizedBox(height: 3,),
                  TextCard(type: 'Nombre:', dato: ruta.nombre,),
                  TextCard(type: 'Telefono:', dato: ruta.telefono,),
                  TextCard(type: 'Placa:', dato: ruta.placa,),
                  TextCard(type: 'Cupos', dato: ruta.cupo),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}