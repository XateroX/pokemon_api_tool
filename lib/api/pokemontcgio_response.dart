import 'dart:convert';

import 'package:pokemon_api_tool/api/pokemontcgio_response_cardstructure.dart';
import 'package:pokemon_api_tool/data_classes/pokemon_card.dart';

class PokemonTCGIOResponse {
  List<Map<String, dynamic>> body = [];
  List<PokemonTCGIOResponseCardStructure> cards = [];

  PokemonTCGIOResponse(Map<String, dynamic> rawResponse) {
    if (rawResponse.containsKey("data")) {
      List data = rawResponse["data"];
      for (var item in data){
        try {
          body.add(item as Map<String,dynamic>);
        } catch(e) {
          print(e);
        }
      }

      // each item in body should be mappable to PokemonTCGIOResponseCardStructure
      for (var item in body) {
        try {
          PokemonTCGIOResponseCardStructure pokemonCard = PokemonTCGIOResponseCardStructure(item);
          cards.add(pokemonCard);
        } catch (e) {
          print(e);
        }
      }

      print("done");
    }
  }
}
