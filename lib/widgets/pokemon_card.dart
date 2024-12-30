import 'package:flutter/material.dart';
import 'package:pokemon_api_tool/api/pokemontcgio_response_cardstructure.dart';

class PokemonCard extends StatelessWidget {
  PokemonTCGIOResponseCardStructure pokemonCard;

  PokemonCard({
    Key? key,
    required this.pokemonCard,
  }) : super(key: key);

  Map<String, double> getAllPricesAsMap(PokemonTCGIOResponseCardStructure pokemonCard){
    Map<String, double> mapToReturn = {};

    void traverse(Map<String, dynamic> map, String path) {
      map.forEach((key, value) {
        String newPath = path.isEmpty ? key : '$path.$key';
        if (value is Map<String, dynamic>) {
          traverse(value, newPath);
        } else if (value is double) {
          mapToReturn[newPath] = value;
        }
      });
    }

    try {
      if (pokemonCard.tcgplayer != null) {
        traverse(pokemonCard.tcgplayer!, '');
      }
    } catch (e){
      print("An error occurred: $e");
    }
    try {
      if (pokemonCard.cardmarket != null) {
        traverse(pokemonCard.cardmarket!, '');
      }
    } catch (e){
      print("An error occurred: $e");
    }
    return mapToReturn;
  }

  @override
  Widget build(BuildContext context) {
    String? imgUrl;
    Map<String,double> prices = getAllPricesAsMap(pokemonCard);
    if (pokemonCard.images?.containsKey("large") ?? false){
      imgUrl = pokemonCard.images!["large"];
    } else if (pokemonCard.images?.containsKey("small") ?? false){
      imgUrl = pokemonCard.images!["small"];
    }
    return imgUrl==null ? Text("Image not found )-:")
    : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: 
      [ 
        Expanded(
          flex:5,
          child: Image.network(
            imgUrl,
            fit: BoxFit.fitHeight,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return SizedBox(
                  width: 200,
                  height: 200,
                  child: Expanded(
                    child: Container(
                      color: Colors.grey[300],
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      ),
                    )
                  ),
                );
              }
            }
          ),
        ),
        Expanded(
          flex:1, 
          child: ListView(
            children: [
              ...prices.entries.map((e) => Text(
                "${e.key}: \$${e.value}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width / 50
                ),
              ))
            ],
          )
        ),
      ]
    );
  }
}
