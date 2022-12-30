// import 'package:retrofit_generator/retrofit_generator.dart'; // Solo quitar para correr build runner
import 'package:pokedex/domain/entities/pokemon_list.dart';
import 'package:pokedex/domain/entities/pokemon_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;



part 'rest_client.g.dart';

//Retrofit client for API requests

@RestApi(baseUrl: "https://pokeapi.co/api/v2/pokemon")
abstract class RestClient{
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;


  @GET("?limit=100000&offset=0")
  Future<PokemonList> getAllCharacters();

  @GET("/{name}")
  Future<PokemonResponse> getCharacterById(@Path("name") String name);

  // @GET("episode")
  // Future<EpisodeResponse> getEpisodes();

// @GET("posts")
// Future<List<PostResponse>> getAllPosts();
//
// @GET("posts?userId={id}")
// Future<List<PostResponse>> getPostsById(@Path("id") int userId);


}