import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/features/home/domain/entities/character.dart';
import 'package:rick_and_morty/features/home/domain/usecase/get_character_usecase.dart';
import 'package:rick_and_morty/features/home/domain/usecase/set_favorite_character_usecase.dart';
import 'package:rick_and_morty/features/home/presentation/bloc/character/character_bloc.dart';

class MockGetCharacterUseCase extends Mock implements GetCharacterUseCase {}

class MockSetFavoriteCharacterUseCase extends Mock
    implements SetFavoriteCharacterUseCase {}

void main() {
  MockGetCharacterUseCase mockGetCharacterUseCase = MockGetCharacterUseCase();
  MockSetFavoriteCharacterUseCase mockSetFavoriteCharacterUseCase =
      MockSetFavoriteCharacterUseCase();
  CharacterBloc bloc = CharacterBloc(
    getCharacterUseCase: mockGetCharacterUseCase,
    setFavoriteCharacterUseCase: mockSetFavoriteCharacterUseCase,
  );
  setUp(() {
    mockGetCharacterUseCase = MockGetCharacterUseCase();
    mockSetFavoriteCharacterUseCase = MockSetFavoriteCharacterUseCase();
    bloc = CharacterBloc(
      getCharacterUseCase: mockGetCharacterUseCase,
      setFavoriteCharacterUseCase: mockSetFavoriteCharacterUseCase,
    );
  });

  test('initialState should be Empty', () async {
    // assert
    expect(bloc.state.status, equals(Status.loading));
  });

  group('GetCharacterUseCase', () {
    final tListCharacter = [
      Character(
        id: 1,
        name: 'Test 1',
        episode: const [],
        gender: '',
        image: '',
        location: const Location(name: 'name', url: 'url'),
        origin: const Location(name: 'name', url: 'url'),
        species: '',
        type: '',
        status: '',
        url: '',
        created: DateTime.now(),
      ),
      Character(
        id: 1,
        name: 'Test 1',
        episode: const [],
        gender: '',
        image: '',
        location: const Location(name: 'name', url: 'url'),
        origin: const Location(name: 'name', url: 'url'),
        species: '',
        type: '',
        status: '',
        url: '',
        created: DateTime.now(),
      ),
    ];

    test('should get List data use case', () async {
      // arrage
      when(mockGetCharacterUseCase(const GetCharacterParams(page: '1')))
          .thenAnswer((_) async => Right(tListCharacter));
      // act
      bloc.add(GetCharacterEvent());
      await untilCalled(
          mockGetCharacterUseCase(const GetCharacterParams(page: '1')));
      // assert
      verify(mockGetCharacterUseCase(const GetCharacterParams(page: '1')));
    });
  });
}
