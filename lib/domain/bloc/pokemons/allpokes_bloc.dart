import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/data/repository/user_repo.dart';
import 'package:pokedex/domain/entities/pokemon_list.dart';

import '../../../data/provider/db_provider.dart';



part 'allpokes_event.dart';
part 'allpokes_state.dart';

class AllPokesBloc extends Bloc<AllPokesEvent, AllPokesState> {
  AllPokesBloc(this.userRepo) : super(InitialAllPokesState());

  final UserRepo userRepo ;


  @override
  void onTransition(Transition<AllPokesEvent, AllPokesState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<AllPokesState> mapEventToState(AllPokesEvent event) async* {
    if (event is FetchAllPokemon) {
      yield FetchingAllPokemon();
      try {
        //consuming api
        final data = await userRepo.fetchCharacters();

        //instantiate database
        DBProvider.db.database;

        //delete previous saved POSTS Database Table
        DBProvider.db.deleteAllPokemon();

        //fill PUBLICACION table with api data
        for (var pub in data.results!) {
          DBProvider.db.createPokemons(pub);
        }

        //get the Posts table
        final dataDb1 = await DBProvider.db.getAllPokemon();


        yield AllPokemonFetched(dataDb1);
      } catch (error) {
        ///EVENTO DE ERROR
        yield ErrorFetching();
        print(error);
        print("hello1");
      }
    }
  }

  AllPokesState get initialState => InitialAllPokesState();
}