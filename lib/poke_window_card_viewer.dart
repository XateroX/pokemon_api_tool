import 'package:flutter/material.dart';
import 'package:pokemon_api_tool/api/pokemontcgio_response_cardstructure.dart';
import 'package:pokemon_api_tool/data_classes/pokemon_card.dart';
import 'package:pokemon_api_tool/widgets/pokemon_card.dart';
import 'package:tuple/tuple.dart';

class PokeWindowCardViewer extends StatelessWidget{
  final Future<Tuple2<Object, List<PokemonTCGIOResponseCardStructure>?>> futureResults;

  PokeWindowCardViewer({
    required this.futureResults
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<Tuple2<Object, List<PokemonTCGIOResponseCardStructure>?>>(
        future: futureResults,
        builder: (BuildContext context, AsyncSnapshot<Tuple2<Object, List<PokemonTCGIOResponseCardStructure>?>> snapshot) { 
          // Handle the different states of the Future
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else if (snapshot.hasData) {
            return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: snapshot.data!.item2==null ? Container(child: Text("No Cards matched that search"),)
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: PageView.builder(
                  itemCount: snapshot.data!.item2!.length,
                  itemBuilder: (context, index) {
                    return PokemonCard(pokemonCard: snapshot.data!.item2![index]);
                  },
                ),
              ),
            );
          } else {
            return Text('Something went wrong!');
          }
        }
      ),
    );
  }

}
