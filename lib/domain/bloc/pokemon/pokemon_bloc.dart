import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as snack;
import 'package:pokedex/data/repository/user_repo.dart';
import 'package:pokedex/domain/entities/pokemon_response.dart';


part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc(this.userRepo) : super(InitialPokemonState());

  final UserRepo userRepo ;


  @override
  void onTransition(Transition<PokemonEvent, PokemonState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    if (event is FetchPokemonByName) {
      yield FetchingPokemon();
      try {
        //consuming api

        final _characterId = event.pokemonName;
        print("hello $_characterId");
        final data = await userRepo.fetchCharacterByName(_characterId);
        print(data);
        yield PokemonFetched(data);
      } catch (error) {
        ///EVENTO DE ERROR
        yield ErrorFetching();
        print(error);
        print("hello");
      }
    }
  }

  PokemonState get initialState => InitialPokemonState();
}