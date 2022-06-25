import 'package:flutter/material.dart';

import '../../../../shared/custom_button.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../widgets/background_image.dart';
import '../widgets/texts_welcome.dart';

class WelcomePage extends StatelessWidget {
  static const id = "welcome_page";
  const WelcomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundImage(
            height: MediaQuery.of(context).size.height,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: const [
                  Image(
                    width: 156,
                    height: 23,
                    image: AssetImage('res/img/logo_squadmakerds.png'),
                    fit: BoxFit.cover,
                  ),
                  Image(
                    width: 271,
                    height: 152,
                    image: AssetImage('res/img/logo_rick_and_morty.png'),
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const TextsWelcome(),
              CustomButton(
                title: 'Continuar',
                onPressed: () {
                  Navigator.pushNamed(context, HomePage.id);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
