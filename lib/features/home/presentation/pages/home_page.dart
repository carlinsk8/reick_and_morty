import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/button_favorite.dart';
import '../../../../shared/custom_button.dart';
import '../bloc/character/character_bloc.dart';
import '../widgets/card_character.dart';
import '../widgets/custom_title.dart';

class HomePage extends StatefulWidget {
  static const id = "home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  bool seeMenu = false;
  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    BlocProvider.of<CharacterBloc>(context).add(GetCharacterEvent());
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      BlocProvider.of<CharacterBloc>(context).add(SetPaginationEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Column(
          children: [
            _headerBar(context),
            const SizedBox(height: 15),
            _rowFavorite(),
            Expanded(
              child: BlocBuilder<CharacterBloc, CharacterState>(
                builder: (context, state) {
                  if (state.status == Status.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == Status.loaded) {
                    return listCharacter(state, context);
                  }
                  if (state.status == Status.error) {
                    return messajeError(context);
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget listCharacter(CharacterState state, BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: state.listCharacter.length,
      itemBuilder: (_, int i) {
        if (i == state.listCharacter.length - 1) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Stack(
              children: [
                CardCharacter(
                  character: state.listCharacter[i],
                ),
                Positioned(
                  bottom: 0,
                  child: Image(
                    height: 113,
                    width: MediaQuery.of(context).size.width,
                    image: Image.asset('res/img/footer.png').image,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          );
        }
        return CardCharacter(
          character: state.listCharacter[i],
        );
      },
    );
  }

  Widget messajeError(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Uh-oh!',
              style: TextStyle(
                fontSize: 30,
                color: Color(0xff081F32),
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              'Pareces perdido en tu viaje',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff081F32),
                fontWeight: FontWeight.w400,
              ),
            ),
            CustomButton(
              title: 'Eliminar Filtros',
              onPressed: () {
                BlocProvider.of<CharacterBloc>(context)
                    .add(GetCharacterEvent());
                _controller.text = '';
              },
            )
          ],
        ),
        const Spacer(),
        Image(
          height: 113,
          width: MediaQuery.of(context).size.width,
          image: Image.asset('res/img/footer.png').image,
          fit: BoxFit.cover,
        )
      ],
    );
  }

  Padding _rowFavorite() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        children: [
          const Text(
            'Mostrar favoritos:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          BlocBuilder<CharacterBloc, CharacterState>(
            builder: (context, state) {
              return ButtonFavorite(
                status: state.favorites,
                onPressed: () {
                  BlocProvider.of<CharacterBloc>(context).add(
                      GetCharacterFilterEvent(favorites: !state.favorites));
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget _headerBar(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 91,
          width: MediaQuery.of(context).size.width,
          color: const Color(0xff081F32),
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: TextFormField(
                    controller: _controller,
                    onFieldSubmitted: (value) {
                      BlocProvider.of<CharacterBloc>(context).add(
                          GetCharacterFilterEvent(
                              name: value, favorites: false));
                    },
                    decoration: const InputDecoration(
                      icon: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      border: InputBorder.none,
                      hintText: 'Buscar personaje...',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 56),
              InkWell(
                onTap: () {
                  setState(() {
                    seeMenu = !seeMenu;
                  });
                },
                child: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30,
                ),
              )
            ],
          ),
        ),
        if (seeMenu)
          Stack(
            children: [
              Container(
                height: 91,
                width: MediaQuery.of(context).size.width,
                color: const Color(0xff081F32),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextButton(
                      setTitle: 'all',
                      title: 'all',
                      onTap: () {
                        BlocProvider.of<CharacterBloc>(context)
                            .add(GetCharacterEvent());
                      },
                    ),
                    CustomTextButton(
                      setTitle: 'unknown',
                      title: 'unknown',
                      onTap: () {
                        BlocProvider.of<CharacterBloc>(context).add(
                            const GetCharacterFilterEvent(gender: 'unknown'));
                      },
                    ),
                    CustomTextButton(
                      setTitle: 'female',
                      title: 'female',
                      onTap: () {
                        BlocProvider.of<CharacterBloc>(context).add(
                            const GetCharacterFilterEvent(gender: 'female'));
                      },
                    ),
                    CustomTextButton(
                      setTitle: 'male',
                      title: 'male',
                      onTap: () {
                        BlocProvider.of<CharacterBloc>(context)
                            .add(const GetCharacterFilterEvent(gender: 'male'));
                      },
                    ),
                    CustomTextButton(
                      setTitle: 'genderless',
                      title: 'genderless',
                      onTap: () {
                        BlocProvider.of<CharacterBloc>(context).add(
                            const GetCharacterFilterEvent(
                                gender: 'genderless'));
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 2,
                top: 2,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      seeMenu = !seeMenu;
                    });
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              )
            ],
          )
      ],
    );
  }
}
