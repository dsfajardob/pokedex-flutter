import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/domain/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/ui/utils/theme.dart' as style;

import '../utils/theme.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = '/details-screen';

  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocBuilder<PokemonBloc, PokemonState>(builder: (context, state) {
        if (state is PokemonFetched) {
          return Scaffold(
            backgroundColor: SetPokemonType()
                .pokemonType(state.pokemon.types![0].type!.name!),
            body: detailsBody(context, state, screenHeight, screenWidth),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: style.AppColors.mainColor,
            ),
          );
        }
      }),
    );
  }

  Stack detailsBody(
      BuildContext context, PokemonFetched state, double height, double width) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 40,
          left: 5,
          child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        Positioned(
            top: 80,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  state.pokemon.name!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "#" + state.pokemon.id.toString(),
                      style: TextStyle(
                        color: SetPokemonType()
                            .pokemonType(state.pokemon.types![0].type!.name!),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            )),
        Positioned(
            top: 120,
            left: 22,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  state.pokemon.types![0].type!.name!,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.left,
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
            )),
        Positioned(
          top: height * 0.18,
          right: -30,
          child: Image.asset(
            'assets/images/pokeball.png',
            height: 200,
            fit: BoxFit.fitHeight,
          ),
        ),
        cardContent(width, height, state),
        Positioned(
          top: (height * 0.2),
          left: (width / 2) - 100,
          child: Hero(
            tag: state.pokemon.id! - 1,
            child: CachedNetworkImage(
              height: 200,
              width: 200,
              imageUrl: const style.Strings().pokeImage(state.pokemon.id!),
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }

  Widget cardContent(double width, double height, PokemonFetched state) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: width * 0.9,
        height: height * 0.6,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            color: Colors.white),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right:30, top: 50),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.3,
                        child: const Text(
                          style.Strings.pokemonName,
                          style:
                              TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey, fontSize: 17),
                        ),
                      ),
                      Text(
                        state.pokemon.name!,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 17, ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.3,
                        child: const Text(
                          style.Strings.pokemonHeight,
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        child: Text(
                          "${state.pokemon.height.toString()} mts",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.3,
                        child: const Text(
                          style.Strings.pokemonWeight,
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "${state.pokemon.weight.toString()} kg",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.28,
                            child: const Text(
                              style.Strings.pokemonStats,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey, fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                    ),

                    UnconstrainedBox(
                      child: Container(
                          height: 130,
                          width: 100,
                          child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/heart.png",
                                            width: 20,
                                          ),
                                          SizedBox(width: width*0.03,),
                                          Text(
                                            state.pokemon.stats![0].baseStat!
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 17),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/swords.png",
                                            width: 20,
                                          ),
                                          SizedBox(width: width*0.03,),
                                          Text(
                                            state.pokemon.stats![1].baseStat!
                                                .toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 17),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.3,
                            child: const Text(
                              style.Strings.pokemonAbility,
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),

                          UnconstrainedBox(
                            child: Container(
                                height: 130,
                                width: 150,
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          state.pokemon.types![0].type!.name! == "grass"
                                              ?
                                          Image.asset(
                                            "assets/images/leaf.png",
                                            width: 20,
                                          ):
                                          state.pokemon.types![0].type!.name! == "fire"
                                              ?
                                          Image.asset(
                                            "assets/images/fire.png",
                                            width: 20,
                                          ):
                                          state.pokemon.types![0].type!.name! == "poison"
                                              ?
                                          Image.asset(
                                            "assets/images/poison.png",
                                            width: 20,
                                          ):
                                          state.pokemon.types![0].type!.name! == "stone"
                                              ?
                                          Image.asset(
                                            "assets/images/stone.png",
                                            width: 20,
                                          ):
                                          state.pokemon.types![0].type!.name! == "electric"
                                              ?
                                          Image.asset(
                                            "assets/images/electric.png",
                                            width: 20,
                                          ):
                                          state.pokemon.types![0].type!.name! == "ground"
                                              ?
                                          Image.asset(
                                            "assets/images/ground.png",
                                            width: 20,
                                          ):
                                          state.pokemon.types![0].type!.name! == "ghost"
                                              ?
                                          Image.asset(
                                            "assets/images/ghost.png",
                                            width: 20,
                                          ):state.pokemon.types![0].type!.name! == "fighting"
                                              ?
                                          Image.asset(
                                            "assets/images/fighting.png",
                                            width: 20,
                                          ):state.pokemon.types![0].type!.name! == "normal"
                                              ?
                                          Image.asset(
                                            "assets/images/normal.png",
                                            width: 20,
                                          ):state.pokemon.types![0].type!.name! == "bug"
                                              ?
                                          Image.asset(
                                            "assets/images/bug.png",
                                            width: 20,
                                          ):Image.asset(
                                            "assets/images/fairy.png",
                                            width: 20,
                                          ),
                                          SizedBox(width: width*0.03,),
                                          Text(
                                            state.pokemon.abilities![0]
                                                .ability!.name!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 17),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          state.pokemon.types![0].type!.name! == "grass"
                                              ?
                                          Image.asset(
                                            "assets/images/leaf.png",
                                            width: 20,
                                          ):
                                          state.pokemon.types![0].type!.name! == "fire"
                                              ?
                                          Image.asset(
                                            "assets/images/fire.png",
                                            width: 20,
                                          ):
                                          state.pokemon.types![0].type!.name! == "poison"
                                              ?
                                          Image.asset(
                                            "assets/images/poison.png",
                                            width: 20,
                                          ):
                                          state.pokemon.types![0].type!.name! == "stone"
                                              ?
                                          Image.asset(
                                            "assets/images/stone.png",
                                            width: 20,
                                          ):
                                          state.pokemon.types![0].type!.name! == "electric"
                                              ?
                                          Image.asset(
                                            "assets/images/electric.png",
                                            width: 20,
                                          ):
                                          state.pokemon.types![0].type!.name! == "ground"
                                              ?
                                          Image.asset(
                                            "assets/images/ground.png",
                                            width: 20,
                                          ):
                                          state.pokemon.types![0].type!.name! == "ghost"
                                              ?
                                          Image.asset(
                                            "assets/images/ghost.png",
                                            width: 20,
                                          ):state.pokemon.types![0].type!.name! == "fighting"
                                              ?
                                          Image.asset(
                                            "assets/images/fighting.png",
                                            width: 20,
                                          ):state.pokemon.types![0].type!.name! == "normal"
                                              ?
                                          Image.asset(
                                            "assets/images/normal.png",
                                            width: 20,
                                          ):state.pokemon.types![0].type!.name! == "bug"
                                              ?
                                          Image.asset(
                                            "assets/images/bug.png",
                                            width: 20,
                                          ):Image.asset(
                                            "assets/images/fairy.png",
                                            width: 20,
                                          ),
                                          SizedBox(width: width*0.03,),
                                          Text(
                                            state.pokemon.abilities![1]
                                                .ability!.name!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 17),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
