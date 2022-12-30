part of 'allpokes_bloc.dart';

abstract class AllPokesEvent extends Equatable {
  const AllPokesEvent();
  @override
  List<Object> get props => [];
}

class FetchAllPokemon extends AllPokesEvent{


  const FetchAllPokemon();
  @override
  List<Object> get props => [];
}

class FetchAllPokemonEvent extends AllPokesEvent{
  @override
  List<Object> get props => [];
}