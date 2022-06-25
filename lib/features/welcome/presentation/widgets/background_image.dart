import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final double height;
  const BackgroundImage({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          width: MediaQuery.of(context).size.width,
          height: height,
          image: const AssetImage('res/img/rick_and_morty.png'),
          fit: BoxFit.cover,
          alignment: const Alignment(-0.5, 0),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: height,
          color: Colors.black.withOpacity(0.8),
        )
      ],
    );
  }
}
