import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/home/presentation/bloc/episodies/episodies_bloc.dart';

import '../../domain/entities/character.dart';
import '../widgets/custom_box.dart';
import '../widgets/headrer_detail.dart';

class PersonDetailPageArg {
  final Character person;

  PersonDetailPageArg({required this.person});
}

class PersonDetailPage extends StatefulWidget {
  static const id = "person_detail_page";
  final PersonDetailPageArg args;
  const PersonDetailPage({Key? key, required this.args}) : super(key: key);

  @override
  State<PersonDetailPage> createState() => _PersonDetailPageState();
}

class _PersonDetailPageState extends State<PersonDetailPage> {
  bool seeMore = true;
  @override
  void initState() {
    BlocProvider.of<EpisodiesBloc>(context)
        .add(GetEpisodiesEvent(widget.args.person.episode));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderDetail(args: widget.args),
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
                    value: widget.args.person.gender,
                  ),
                  CustomBox(
                    keyValue: 'Origin',
                    value: widget.args.person.origin.name,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
              child: CustomBox(
                keyValue: 'Type',
                value: widget.args.person.species,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30, left: 16, right: 16),
              child: Text(
                'Episodios',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff7A7A7A),
                ),
              ),
            ),
            BlocBuilder<EpisodiesBloc, EpisodieState>(
              builder: (context, state) {
                if (state.status == Status.loading) {
                  return const CircularProgressIndicator();
                }
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.listEpisodie.length > 4
                      ? seeMore
                          ? 4
                          : state.listEpisodie.length
                      : state.listEpisodie.length,
                  itemBuilder: (_, i) {
                    return CustomCardEpisodie(
                      episodie: state.listEpisodie[i],
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 110,
                  ),
                );
              },
            ),
            BlocBuilder<EpisodiesBloc, EpisodieState>(
              builder: (context, state) {
                if (state.listEpisodie.length > 4) {
                  return Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          seeMore = !seeMore;
                        });
                      },
                      child: Text(
                        seeMore ? 'Ver más' : 'Ver menos',
                        style: const TextStyle(
                            color: Color(0xff12555F),
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            //TODO no hay endpoint para Personajes Interesantes
            // const Padding(
            //   padding: EdgeInsets.only(top: 30, left: 16, right: 16),
            //   child: Text(
            //     'Personajes Interesantes',
            //     style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.w500,
            //       color: Color(0xff7A7A7A),
            //     ),
            //   ),
            // ),
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

class CustomCardEpisodie extends StatelessWidget {
  final Episodie episodie;
  const CustomCardEpisodie({
    Key? key,
    required this.episodie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 162,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: const Color(0xffB9B9B9),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.info,
                  color: Color(0xff7A7A7A),
                ),
                Expanded(
                  child: Text(
                    episodie.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            Text(
              episodie.episode,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                const Icon(
                  Icons.info,
                  color: Color(0xff7A7A7A),
                ),
                Expanded(
                  child: Text(
                    episodie.airDate,
                    style: const TextStyle(fontSize: 13),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
