import 'package:flutter/material.dart';
import 'package:pokemon_api_tool/api/pokemontcgio_response_cardstructure.dart';

class PokemonCard extends StatelessWidget {
  PokemonTCGIOResponseCardStructure pokemonCard;

  PokemonCard({
    Key? key,
    required this.pokemonCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? imgUrl;
    if (pokemonCard.images?.containsKey("large") ?? false){
      imgUrl = pokemonCard.images!["large"];
    } else if (pokemonCard.images?.containsKey("small") ?? false){
      imgUrl = pokemonCard.images!["small"];
    }
    return imgUrl==null ? Text("Image not found )-:")
    : Image.network(
      imgUrl,
      fit: BoxFit.fitHeight,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return Stack(
            alignment: Alignment.center,
            children: 
            [ 
            // SizedBox(
            //   width: 200,
            //   height: 200,
            //   child: Expanded(
            //     child: Container(
            //       color: Colors.grey[300],
            //       child: Center(
            //         child: CircularProgressIndicator(),
            //       ),
            //     )
            //   ),
            // ),
            child 
          ]);
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
    );
  }
}
