import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex/data/provider/db_provider.dart';
import 'package:pokedex/domain/bloc/pokemon/pokemon_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/ui/screens/details_screen.dart';
import 'package:pokedex/ui/utils/theme.dart' as style;

import '../../domain/entities/pokemon_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  final dbHelper = DBProvider.db;
  String keyword = '';
  late String userName;

  void fetchIndividualCharacter(String id) {
    BlocProvider.of<PokemonBloc>(context)
        .add(FetchPokemonByName(pokemonName: id)
            // FetchBusinessEvent()
            );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text(style.Strings.appTitle),
          ),
          body: FutureBuilder<List<Results>>(
              future: dbHelper.searchPokemons(keyword),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Results>> snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: Lottie.asset("assets/diglett.json"),
                  );
                } else {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                            labelText: style.Strings.searchBarTitle,
                          ),
                          onChanged: (value) {
                            keyword = value;
                            setState(() {});
                          },
                        ),
                      ),
                      _characterList(context, snapshot),
                    ],
                  );

                  // return _characterList(context, snapshot);
                }
              })),
    );
  }



  Widget _characterList(
      BuildContext context, AsyncSnapshot<List<Results>> snapshot) {
    return Stack(children: [
      Positioned(
        top: 80,
        bottom: 0,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1.4),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: InkWell(
                          child: SafeArea(
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: -10,
                                    right: -10,
                                    child: Image.asset(
                                      'assets/images/pokeball.png',
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: Hero(
                                      tag: index,
                                      child: CachedNetworkImage(
                                          imageUrl:
                                             const style.Strings().urlImageFormatter(snapshot.data![index].url!) ,
                                          height: 100,
                                          fit: BoxFit.fitHeight,
                                          placeholder: (context, url) =>
                                              const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            bottomRight: Radius.circular(25),
                                          )),
                                      height: 40,
                                      width: 90,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            snapshot.data![index].name!,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            fetchIndividualCharacter(
                                snapshot.data![index].name!);
                            Navigator.pushNamed(
                                context, DetailsScreen.routeName);
                          },
                        ),
                      );
                    }))
          ],
        ),
      ),
      Positioned(
        top: 0,
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    ]);
  }
}
