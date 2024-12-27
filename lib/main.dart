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

  void updateCardQueryAndSearch(String value){
    if (value == ""){
      _futureCardSearchResults = null;
    } else {
      _futureCardSearchResults = api.getCardByNumberString(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    Widget textField = PokeTextField(
      setFutureCardCallback: (String value){
        setState((){
          updateCardQueryAndSearch(value);
        });
      },
    );
    Widget title = PokeTitle();

    final isWide = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    return Center(
      child: isWide
      ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [ 
            Expanded(
              flex:1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: DefaultTextStyle.of(context).style.fontSize! * 5,
                    child: title
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width /1.5,
                    height: DefaultTextStyle.of(context).style.fontSize! * 3,
                    child: textField
                  ),
                  Text("W:${MediaQuery.of(context).size.width} H:${MediaQuery.of(context).size.height}")
                ],
              ),
            ),
            AnimatedContainer(
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 500),
              width: _futureCardSearchResults==null ? 0 : MediaQuery.of(context).size.width / 1.5,
              height: _futureCardSearchResults==null ? 0 : MediaQuery.of(context).size.height / 2,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
        [ 
          Expanded(
            flex:1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: DefaultTextStyle.of(context).style.fontSize! * 5,
                  child: title
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width /1.5,
                  height: DefaultTextStyle.of(context).style.fontSize! * 3,
                  child: textField
                ),
                Text("W:${MediaQuery.of(context).size.width} H:${MediaQuery.of(context).size.height}")
              ],
            ),
          ),
          AnimatedContainer(
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 500),
              width: _futureCardSearchResults==null ? 0 : MediaQuery.of(context).size.width,
              height: _futureCardSearchResults==null ? 0 : MediaQuery.of(context).size.height / 1.25,
              child: Center(
              child: _futureCardSearchResults==null ? Container()
              : PokeWindowCardViewer(
                futureResults:_futureCardSearchResults!
              )
            ),
          ),
        ],
      )
    );
  }
}
