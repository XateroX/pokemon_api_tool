import 'package:flutter/material.dart';

class PokeTextField extends StatelessWidget {
  final Function(String) setFutureCardCallback;
  final TextEditingController textController;

  PokeTextField({
    Key? key,
    required this.setFutureCardCallback,
    required this.textController,
  }) : super(key: key);
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.requestFocus(); // Request focus when the widget is initialized
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Clean up the FocusNode when the widget is disposed
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        controller: textController,
        focusNode: _focusNode,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter a number (XXX/YYY)',
        ),
        onSubmitted: (value){
          setFutureCardCallback(value);
        },
      )
    );
  }
}
