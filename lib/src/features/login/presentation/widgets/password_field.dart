import 'package:flutter/material.dart';

import '../../../../core/config/styles/margin.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  MyPasswordFieldState createState() => MyPasswordFieldState();
}

class MyPasswordFieldState extends State<PasswordField> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppSpacing.lg, bottom: AppSpacing.dd),
      child: TextFormField(
        controller: widget.controller,
        obscureText: isObscured,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: isObscured ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              color: Theme.of(context)
                  .iconTheme
                  .color,
              onPressed: () {
                setState(() {
                  isObscured =
                  !isObscured;
                });
              },
            ),
            labelText: "Contraseña"),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor complete este campo';
          }
          return null;
        },
      ),
    );
  }
}