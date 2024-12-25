import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pokemon_api_tool/api/pokemontcgio_response.dart';
import 'package:pokemon_api_tool/api/pokemontcgio_response_cardstructure.dart';
import 'package:pokemon_api_tool/data_classes/pokemon_card.dart';
import 'package:tuple/tuple.dart';
import 'dart:html' as html;

class PokemontcgioApi {
  String apiUrl = "https://api.pokemontcg.io";
  // ignore: non_constant_identifier_names
  String? _POKEMONTCGIO_CREDENTIALS;
  Map<String,String>? authHeader;
  List<Map<String, int>> setSizes = [];

  PokemontcgioApi(){
    init();
  }

  Future<void> init() async {
    await dotenv.load(fileName: ".env");
    _POKEMONTCGIO_CREDENTIALS = dotenv.env['POKEMONTCGIO_CREDENTIALS'];
    assert(_POKEMONTCGIO_CREDENTIALS!=null);
    authHeader = {
      'Authorization': 'X-Api-Key: ${_POKEMONTCGIO_CREDENTIALS as String}',
      'Content-Type': 'application/json'
    };
    // await testCall();
    // await getCardByNumberString("10/300");

    // Load JSON and decode
    final json = jsonDecode(await rootBundle.loadString('all_set_sizes.json'));
    var setList = json["data"] as List;
    setList.forEach(
      (item) {
        print(item["id"]);
        print(item["total"].toString() + "\n");
      }
    );
  }

  Future<Object?> testCall() async {
    // try to call the api and see what happens
    Uri baseUrl = Uri.parse("$apiUrl/v2/sets");
    Uri urlWithParams = baseUrl.replace(queryParameters: {});
    http.Response res = await http.get(
      urlWithParams,
      headers: authHeader,
    );

    // format the res.body as a json Object
    Object? resJson = jsonDecode(res.body);
    print("api responding? ${resJson!=null}");

    void saveFile(String filename, String content) {
      // Create a Blob
      final bytes = Uint8List.fromList(utf8.encode(content));
      final blob = html.Blob([bytes]);

      // Create a download link
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..target = 'blank'
        ..download = filename
        ..click();

      // Cleanup
      html.Url.revokeObjectUrl(url);
    }

    saveFile("response.json", res.body);

    return resJson;
  }
  Future<Tuple2<Object, List<PokemonTCGIOResponseCardStructure>?>> getCardByNumberString(String numberString) async {
    try{
      // extract the number we need
      String? number = numberString.split('/').firstOrNull;
      if (number==null){
        return Tuple2<Object, List<PokemonTCGIOResponseCardStructure>?>(false, null);
      }
      String? secondNumber = numberString.split('/').lastOrNull;
      if (secondNumber==null){
        return Tuple2<Object, List<PokemonTCGIOResponseCardStructure>?>(false, null);
      }

      // get a card by searching for cards with the same set number
      Uri baseUrl = Uri.parse("$apiUrl/v2/cards");
      Uri urlWithParams = baseUrl.replace(queryParameters: {'q':'number:$number'});
      http.Response res = await http.get(
        urlWithParams,
        headers: authHeader,
      );

      // format the res.body as a json Object
      PokemonTCGIOResponse? pokemonResponse = PokemonTCGIOResponse(jsonDecode(res.body));

      // look at all the cards in the response and pick the first one, return it
      if (pokemonResponse.cards.isNotEmpty){
        // find the one with the right set printed item
        PokemonTCGIOResponseCardStructure? correctCard;

        List<PokemonTCGIOResponseCardStructure> returnList = [];
        for (PokemonTCGIOResponseCardStructure card in pokemonResponse.cards){
          if (card.set?["printedTotal"].toString() == secondNumber){
            returnList.add(card);
          }
        }

        if (returnList.isNotEmpty){
          return Tuple2<Object, List<PokemonTCGIOResponseCardStructure>?>(true, returnList);
        }

        return Tuple2<Object, List<PokemonTCGIOResponseCardStructure>?>(true, pokemonResponse.cards);
      }

      return Tuple2<Object, List<PokemonTCGIOResponseCardStructure>?>(false, null);
    } catch(e) {
      return Tuple2<Object, List<PokemonTCGIOResponseCardStructure>?>(e, null);
    }
  }
}
