import 'package:flutter/material.dart';

class TextsWelcome extends StatelessWidget {
  const TextsWelcome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          Text(
            'Bienvenido \na Rick and Morty',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              height: 1.3,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            'En esta prueba, evaluaremos su capacidad\npara construit la aplicación mediante el\nanálisis de código\ny la reproducción del siquiente diseño.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.24,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
