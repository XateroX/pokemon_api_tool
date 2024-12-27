import 'package:flutter/material.dart';

class PokeTextField extends StatefulWidget {
  final Function(String) setFutureCardCallback;

  const PokeTextField({
    Key? key,
    required this.setFutureCardCallback,
  }) : super(key: key);

  @override
  _PokeTextFieldState createState() => _PokeTextFieldState();
}

class _PokeTextFieldState extends State<PokeTextField> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus(); // Request focus when the widget is initialized
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose(); // Clean up the FocusNode when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        controller: _textController,
        focusNode: _focusNode,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter a number (XXX/YYY)',
        ),
        onEditingComplete: (){
          widget.setFutureCardCallback(_textController.text);
        },
      )
    );
  }
}
