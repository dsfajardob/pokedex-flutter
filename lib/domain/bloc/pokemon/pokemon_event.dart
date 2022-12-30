part of 'pokemon_bloc.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();
  @override
  List<Object> get props => [];
}

class FetchPokemonByName extends PokemonEvent{

  final String pokemonName;

  const FetchPokemonByName({required this.pokemonName});
  @override
  List<Object> get props => [pokemonName];
}

class FetchPokemonEvent extends PokemonEvent{
  @override
  List<Object> get props => [];
}