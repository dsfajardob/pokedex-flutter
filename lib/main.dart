import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/data/repository/user_repo.dart';
import 'package:pokedex/domain/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/domain/bloc/pokemons/allpokes_bloc.dart';
import 'package:pokedex/ui/screens/details_screen.dart';
import 'package:pokedex/ui/screens/home_page.dart';
import 'package:pokedex/ui/screens/home_screen.dart';

void main() {
  final userRepo = UserRepo();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<AllPokesBloc>(create: (context) {
          return AllPokesBloc(userRepo)..add(const FetchAllPokemon());
        }),
        BlocProvider<PokemonBloc>(create: (context) {
          return PokemonBloc(userRepo)..add(FetchPokemonEvent());
        }),

      ],
      child: MyApp(
        repository:userRepo,
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required UserRepo repository}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        // HomePage.routeName: (context) => HomePage(),
        DetailsScreen.routeName: (context) => DetailsScreen(),
        //
        // 'splash': ( _ ) => SplashPage(),
        // 'register': ( _ ) => RegisterPage(),
        // 'home' : ( _ ) => HomePage(),
      },
    );
  }
}
