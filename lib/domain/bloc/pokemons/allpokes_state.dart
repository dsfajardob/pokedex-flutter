part of 'allpokes_bloc.dart';


abstract class AllPokesState extends Equatable {}

class InitialAllPokesState extends AllPokesState{
  @override
  List<Object> get props => [];
}
// success state
class AllPokemonFetched extends AllPokesState {
  final List<Results>? pokemon;

  AllPokemonFetched(this.pokemon);

  @override
  List<Object> get props => [];
}
//loading state
class FetchingAllPokemon extends AllPokesState{
  @override
  List<Object> get props => [];

//error state
}class ErrorFetching extends AllPokesState{
  @override
  List<Object> get props => [];
}