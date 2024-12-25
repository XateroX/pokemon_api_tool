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
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > constraints.maxHeight;
          return isWide
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [ 
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: _futureCardSearchResults==null ? MediaQuery.of(context).size.width /3 : MediaQuery.of(context).size.width /3,
                        height: DefaultTextStyle.of(context).style.fontSize! * 5,
                        child: PokeTitle()
                      ),
                      SizedBox(
                        width: _futureCardSearchResults==null ? MediaQuery.of(context).size.width /3 : MediaQuery.of(context).size.width /5,
                        height: DefaultTextStyle.of(context).style.fontSize! * 3,
                        child:  PokeTextField(
                          setFutureCardCallback: (String value){
                            setState((){
                              updateCardQueryAndSearch(value);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  AnimatedContainer(
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 500),
                    width: _futureCardSearchResults==null ? 0 : constraints.maxWidth / 1.5,
                    height: _futureCardSearchResults==null ? 0 : constraints.maxHeight / 2,
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
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width /2,
                        height: DefaultTextStyle.of(context).style.fontSize! * 5,
                        child: PokeTitle()
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width /2,
                        height: DefaultTextStyle.of(context).style.fontSize! * 3,
                        child:  PokeTextField(
                          setFutureCardCallback: (String value){
                            setState((){
                              updateCardQueryAndSearch(value);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  AnimatedContainer(
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 500),
                    width: _futureCardSearchResults==null ? 0 : constraints.maxWidth,
                    height: _futureCardSearchResults==null ? 0 : constraints.maxHeight / 1.25,
                    child: Center(
                      child: _futureCardSearchResults==null ? Container()
                      : PokeWindowCardViewer(
                        futureResults:_futureCardSearchResults!
                      )
                    ),
                  ),
                ],
              );
        },
      ),
    );
  }

}
