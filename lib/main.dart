import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokemon_api_tool/api/pokemontcgio_api.dart';
import 'package:pokemon_api_tool/api/pokemontcgio_response_cardstructure.dart';
import 'package:pokemon_api_tool/data_classes/pokemon_card.dart';
import 'package:pokemon_api_tool/poke_window_card_viewer.dart';
import 'package:pokemon_api_tool/widgets/poke_text_field.dart';
import 'package:pokemon_api_tool/widgets/poke_title.dart';
import 'package:tuple/tuple.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: PokeWindow()
      ),
    );
  }
}


class PokeWindow extends StatefulWidget {
  const PokeWindow({super.key});

  @override
  _PokeWindowState createState() => _PokeWindowState();
}


class _PokeWindowState extends State<PokeWindow> {
  final PokemontcgioApi api = PokemontcgioApi();
  Future<Tuple2<Object, List<PokemonTCGIOResponseCardStructure>?>>? _futureCardSearchResults;
  TextEditingController textController = TextEditingController();
  String? textControllerValueSaved;

  void updateCardQueryAndSearch(String value){
    if (value == ""){
      setState((){
        _futureCardSearchResults = null;
      });
    } else {
      setState((){
        _futureCardSearchResults = api.getCardByNumberString(value);
      });
    }
  }

  void setValueOfMyState(String value){
    setState((){
      textControllerValueSaved = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget textField = PokeTextField(
      setFutureCardCallback: updateCardQueryAndSearch,
      textController: textController,
    );
    Widget title = PokeTitle();

    final isWide = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: isWide
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            [ 
              Container(
                width: _futureCardSearchResults==null 
                ? MediaQuery.of(context).size.width / 1.5
                : MediaQuery.of(context).size.width / 2.5,
                height: MediaQuery.of(context).size.height / 3,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2, // Half the width
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      title,
                      textField,
                      // Text("W:${MediaQuery.of(context).size.width} H:${MediaQuery.of(context).size.height}")
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                width: _futureCardSearchResults==null ? 0 : 1.5*MediaQuery.of(context).size.width / 2.5,
                height: 4*MediaQuery.of(context).size.height / 5,
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 200),
                child: Center(
                  child: _futureCardSearchResults==null ? Container()
                  : PokeWindowCardViewer(
                    futureResults:_futureCardSearchResults!
                    )
                ),
              ),
            ],
          )
        : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [ 
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: _futureCardSearchResults==null 
              ? MediaQuery.of(context).size.height / 3 
              : MediaQuery.of(context).size.height / 5,
              child: Container(
                width: MediaQuery.of(context).size.width / 2, // Half the width
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    title,
                    textField,
                    // Text("W:${MediaQuery.of(context).size.width} H:${MediaQuery.of(context).size.height}")
                  ],
                ),
              ),
            ),
            AnimatedContainer(
              width: MediaQuery.of(context).size.width / 1.2,
              height: _futureCardSearchResults==null ? 0 : 2 * MediaQuery.of(context).size.height / 3,
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 500),
              child: Center(
                child: _futureCardSearchResults==null ? Container()
                : PokeWindowCardViewer(
                  futureResults:_futureCardSearchResults!
                )
              ),
            ),
          ],
        )
      ),
    );
  }
}