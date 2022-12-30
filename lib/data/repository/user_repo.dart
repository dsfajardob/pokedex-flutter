import 'package:dio/dio.dart';
import 'package:pokedex/data/services/rest_client.dart';
import 'package:pokedex/domain/entities/pokemon_list.dart';
import 'package:pokedex/domain/entities/pokemon_response.dart';

class UserRepo{

  static final UserRepo _userRepo = UserRepo.internal();

  factory UserRepo(){
    return _userRepo;
  }
  UserRepo.internal();

  static final dio = Dio(BaseOptions(contentType: "application/json"));

  RestClient _client = RestClient(dio);

  // //Get all users from API
  Future<PokemonList> fetchCharacters() async{
    return await _client.getAllCharacters();
  }
  //Get all users from API
  Future<PokemonResponse> fetchCharacterByName(String name) async{
    return await _client.getCharacterById(name);
  }

  // Future<EpisodeResponse> fetchEpisodes() async{
  //   return await _client.getEpisodes();
  // }

}