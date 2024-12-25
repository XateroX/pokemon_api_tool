import 'package:flutter/material.dart';
import 'package:pokemon_api_tool/api/pokemontcgio_api.dart';
import 'package:pokemon_api_tool/api/pokemontcgio_response_cardstructure.dart';
import 'package:tuple/tuple.dart';

class PokeTextField extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFocusNode = FocusNode();
  final Function(String) setFutureCardCallback;

  PokeTextField({
    Key? key,
    required this.setFutureCardCallback,
  }) : super(key: key);

  @override
  void initState() {
    _textFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _textFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        controller: _textController,
        focusNode: _textFocusNode,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter a Pokemon name or number (XXX/YYY)',
        ),
        onSubmitted: (value) {
          setFutureCardCallback(value);
        },
      ),
    );
  }
}