part of 'pokemon_bloc.dart';

abstract class PokemonState extends Equatable {}

class InitialPokemonState extends PokemonState{
  @override
  List<Object> get props => [];
}
// success state
class PokemonFetched extends PokemonState {
  final PokemonResponse pokemon;

  PokemonFetched(this.pokemon);

  @override
  List<Object> get props => [pokemon];

}
//loading state
class FetchingPokemon extends PokemonState{
  @override
  List<Object> get props => [];

//error state
}class ErrorFetching extends PokemonState{
  @override
  List<Object> get props => [];
}