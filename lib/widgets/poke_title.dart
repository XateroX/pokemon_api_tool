import 'package:flutter/material.dart';

class PokeTitle extends StatelessWidget {
  PokeTitle();

  @override
  Widget build(BuildContext context){
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          text: TextSpan(
            children: 
            [
              TextSpan(
                text: 'PokeWindow',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Colors.blue
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}