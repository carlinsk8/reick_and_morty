import 'package:flutter/material.dart';

import '../../domain/entities/character.dart';
import '../widgets/custom_box.dart';
import '../widgets/headrer_detail.dart';

class PersonDetailPageArg {
  final Character person;

  PersonDetailPageArg({required this.person});
}

class PersonDetailPage extends StatelessWidget {
  static const id = "person_detail_page";
  final PersonDetailPageArg args;
  const PersonDetailPage({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderDetail(args: args),
            const Padding(
              padding: EdgeInsets.only(top: 30, left: 16, right: 16),
              child: Text(
                'Información',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff7A7A7A),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBox(
                    keyValue: 'Gender',
                    value: args.person.gender,
                  ),
                  CustomBox(
                    keyValue: 'Origin',
                    value: args.person.origin.name,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
              child: CustomBox(
                keyValue: 'Type',
                value: args.person.species,
              ),
            ),
            const SizedBox(height: 30),
            Image(
              height: 113,
              width: MediaQuery.of(context).size.width,
              image: Image.asset('res/img/footer.png').image,
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}
