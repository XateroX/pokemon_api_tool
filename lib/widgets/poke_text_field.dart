import 'package:flutter/material.dart';

class PokeTextField extends StatefulWidget {
  final Function(String) setFutureCardCallback;
  final TextEditingController textController;
  // final FocusNode textFocusNode;

  const PokeTextField({
    Key? key,
    required this.setFutureCardCallback,
    required this.textController,
    // required this.textFocusNode,
  }) : super(key: key);

  @override
  _PokeTextFieldState createState() => _PokeTextFieldState();
}

class _PokeTextFieldState extends State<PokeTextField> {
  

  // @override
  // void initState() {
  //   super.initState();
  //   widget.textFocusNode.requestFocus(); // Request focus when the widget is initialized
  // }

  // @override
  // void dispose() {
  //   widget.textFocusNode.dispose(); // Clean up the FocusNode when the widget is disposed
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        controller: widget.textController,
        // focusNode: widget.textFocusNode,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter a Pokemon name or number (XXX/YYY)',
        ),
        onSubmitted: (value) {
          widget.setFutureCardCallback(value);
        },
      ),
    );
  }
}
