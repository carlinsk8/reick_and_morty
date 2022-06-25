import 'package:flutter/material.dart';

import '../../../../shared/button_favorite.dart';
import '../pages/person_detail_page.dart';

class HeaderDetail extends StatelessWidget {
  const HeaderDetail({
    Key? key,
    required this.args,
  }) : super(key: key);

  final PersonDetailPageArg args;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Image(
              height: 181,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              image: Image.asset('res/img/banner_detail.png').image,
            ),
            Container(
              height: 181,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xff081F32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.circle,
                        color: Color(0xffB2DF28),
                        size: 8,
                      ),
                      Text(
                        args.person.status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    args.person.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    args.person.species,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ],
        ),
        Positioned.fill(
          top: 110,
          child: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 65,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(
                      image: NetworkImage(args.person.image),
                      width: 122,
                      height: 122,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned.fill(
          top: 210,
          child: Align(
            alignment: Alignment.topCenter,
            child: ButtonFavorite(
              status: false,
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        )
      ],
    );
  }
}
