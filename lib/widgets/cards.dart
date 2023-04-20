import 'package:flutter/material.dart';

class CardInicio extends StatelessWidget {
  const CardInicio({
    Key? key, required this.navegator, required this.image, required this.titulo, required this.ancho,
  }) : super(key: key);

  final Function navegator;
  final String image;
  final String titulo;
  final double ancho;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    
    return GestureDetector(
      onTap: (){
        navegator();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        width: size.width * ancho,
        height: size.height * 0.20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFFFFFFF),
          boxShadow: const[
            BoxShadow(
              color: Colors.black12,
              offset: Offset(7, 5),
              blurRadius: 6
            )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.3,
              height: size.height * 0.1,
              child: Image(image: AssetImage(image))
            ),
            const SizedBox(height: 10,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center,)
            )
          ],
        ),
      ),
    );
  }
}