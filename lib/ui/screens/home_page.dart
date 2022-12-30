import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex/domain/bloc/pokemons/allpokes_bloc.dart';
import 'package:pokedex/ui/screens/home_screen.dart';
import 'package:pokedex/ui/utils/theme.dart' as style;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: BlocBuilder<AllPokesBloc, AllPokesState>(builder: (context, state) {
          if (state is AllPokemonFetched) {
            return const HomeScreen();
          } else {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.height * 0.2,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Lottie.asset("assets/loading.json")),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    style.Strings.appLoader,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }
        }));
  }
}
