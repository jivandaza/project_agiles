import 'package:flutter/material.dart';
import 'package:project_agiles/models/ruta_model.dart';
import 'package:url_launcher/url_launcher.dart';

class RutaPage extends StatelessWidget {
  const RutaPage({super.key, this.rutas});

  final List<Ruta>? rutas;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choferes en turno'),
        centerTitle: true,
      ),
      body: rutas != null ?
      Container(
        margin: EdgeInsets.symmetric(vertical: size.height * 0.04),
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
          itemCount: rutas!.length,
          itemBuilder: (context, index) {
            return CardRuta(size: size, ruta: rutas![index],);
          },
        ),
      ) : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.7,
              child: const Image(image: AssetImage('assets/sinTransporte.jpg')),
            ),
            const SizedBox(height: 20,),
            const Text('No hay choferes en turno', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            const SizedBox(height: 20,),
          ],
        ),
      )
    );
  }
}

class CardRuta extends StatelessWidget {
  const CardRuta({
    Key? key,
    required this.size, required this.ruta,
  }) : super(key: key);

  final Ruta ruta;
  final Size size;

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
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
                  SizedBox(
                    width: size.width * 0.58,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () async{
                            final Uri url = Uri.parse('whatsapp://send?phone=+57${ruta.telefono}');
                            launchUrl(url);
                          },
                          /*child: const Icon(Icons.whatsapp, color: Colors.green, size: 30,)*/
                        ),
                        const SizedBox(width: 15,),
                        InkWell(
                          onTap: () async{
                            final Uri phone = Uri.parse('tel:+57${ruta.telefono}');
                            launchUrl(phone);
                          },
                          child: const Icon(Icons.phone, color: Colors.blue, size: 30)
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextCard extends StatelessWidget {
  const TextCard({
    Key? key, required this.type, required this.dato,
  }) : super(key: key);

  final String type;
  final String dato;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.006),
      child: Row(
        children: [
          Text('${type} ', style: const TextStyle( fontWeight: FontWeight.bold),),
          Text(dato, style: const TextStyle( fontWeight: FontWeight.normal),),        
        ],
      ),
    );
  }
}