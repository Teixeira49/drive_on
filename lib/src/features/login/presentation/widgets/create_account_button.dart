
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text:
            "¿No tienes una cuenta? ",
            style: const TextStyle(
                fontSize: 15,
                color:
                Colors.black54),
            children: [
              TextSpan(
                  text: 'Registrate',
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.blue),
                  recognizer:
                  TapGestureRecognizer()
                    ..onTap = () {
                      print(
                          'registrar');
                    })
            ]));
  }


}