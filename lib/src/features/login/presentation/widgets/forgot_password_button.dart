import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 6, top: 2),
        child: TextButton(
          onPressed: () {},
          child: const Text("¿Olvidaste tu contraseña?",
              style: TextStyle(fontSize: 15, color: Colors.blue)),
        ));
  }
}
