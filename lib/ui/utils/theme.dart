import 'package:flutter/material.dart';

class AppColors {
  const AppColors();

  static const Color mainColor = Color.fromRGBO(0, 0, 128, 1);
  static const Color darkBlue = Color.fromRGBO(7, 42, 108, 1);
  static const Color grassType = Colors.greenAccent;
  static const Color fireType = Colors.redAccent;
  static const Color waterType = Colors.blue;
  static const Color poisonType = Colors.deepPurpleAccent;
  static const Color electricType = Colors.amber;
  static const Color rockType = Colors.grey;
  static const Color groundType = Colors.brown;
  static const Color psychicType = Colors.indigo;
  static const Color fightingType = Colors.orange;
  static const Color bugType = Colors.lightGreen;
  static const Color ghostType = Colors.deepPurple;
  static const Color normalType = Colors.black26;
  static const Color otherType = Colors.pink;
}

class Strings {
  const Strings();

  static const String appLoader = "Welcome, it should take a few seconds";
  static const String appTitle = "Pokedex";
  static const String searchBarTitle = "Pokemon search";
  static const String pokemonName = "Name";
  static const String pokemonHeight = "Height";
  static const String pokemonWeight = "Weight";
  static const String pokemonAbility = "Abilities";
  static const String pokemonStats = "Stats";
  static const String pokemonPreEvolution = "Pre-Evolution";
  static const String pokemonEvolution = "Evolution";

  String urlImageFormatter(String pokemonUrl){
    String pokemonNumber = pokemonUrl.substring(34).replaceAll(RegExp('[^A-Za-z0-9]'), '');
    String imageLink = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonNumber.png";
    return imageLink;
  }

  String pokeImage(int pokemonId){
    String image = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonId.png";
    return image;
  }
}

class SetPokemonType {

  pokemonType(String type) {
    String pokemonType = type;

    switch (pokemonType) {
      case "grass":
        return AppColors.grassType;

      case "fire":
        return AppColors.fireType;

      case "water":
        return AppColors.waterType;

      case "poison":
        return AppColors.poisonType;

      case "electric":
        return AppColors.electricType;

      case "rock":
        return AppColors.rockType;

      case "ground":
        return AppColors.groundType;

      case "psychic":
        return AppColors.psychicType;

      case "fighting":
        return AppColors.fightingType;

      case "bug":
        return AppColors.bugType;

      case "ghost":
        return AppColors.ghostType;

      case "normal":
        return AppColors.normalType;

      default:
        return AppColors.otherType;
    }
  }
}
