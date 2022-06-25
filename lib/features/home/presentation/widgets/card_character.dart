import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/home/presentation/pages/person_detail_page.dart';
import 'package:rick_and_morty/shared/button_favorite.dart';

import '../../domain/entities/character.dart';
import '../bloc/character/character_bloc.dart';

class CardCharacter extends StatelessWidget {
  final Character character;
  const CardCharacter({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, PersonDetailPage.id,
            arguments: PersonDetailPageArg(person: character));
      },
      child: Container(
        height: 150,
        margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: const Color(0xffB9B9B9),
          ),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: Image(
                    image: NetworkImage(character.image),
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: ButtonFavorite(
                    status: character.favorite,
                    onPressed: () {
                      BlocProvider.of<CharacterBloc>(context)
                          .add(SetFavoriteEvent(character.id));
                    },
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        color: Color(0xffB2DF28),
                        size: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          '${character.status} - ${character.species}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      character.name,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      character.location.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      character.origin.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBackground extends StatelessWidget {
  final Widget child;
  const CustomBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: Transform.scale(
                  alignment: const Alignment(-0.8, -1),
                  filterQuality: FilterQuality.high,
                  scale: 1.8,
                  child: Image(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.15,
                    image: const AssetImage('res/img/rick_and_morty.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(0.8),
              ),
              const SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image(
                    width: 245,
                    height: 138,
                    image: AssetImage('res/img/logo_rick_and_morty.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.75,
            child: child,
          )
        ],
      ),
    );
  }
}
