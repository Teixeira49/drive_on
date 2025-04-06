import 'package:flutter/material.dart';

import '../../../../core/config/styles/margin.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({super.key, required this.function});

  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.sm),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          gradient:
          const LinearGradient(
            colors: [
              Colors.blue,
              Colors.cyanAccent
            ],
            begin: Alignment.topLeft,
            end:
            Alignment.bottomRight,
          ),
          borderRadius:
          BorderRadius.circular(
              30.0), // Uniform radius
        ),
        child: ElevatedButton(
            style: ElevatedButton
                .styleFrom(
                elevation: 5,
                backgroundColor: Colors
                    .transparent,
                shadowColor: Colors
                    .transparent,
                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius
                      .circular(
                      30),
                ),
                alignment:
                Alignment
                    .center,
                padding:
                const EdgeInsets
                    .symmetric(
                    horizontal:
                    24,
                    vertical:
                    8)),
            onPressed: function,
            child: const Text(
              'Continuar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight:
                FontWeight.bold,
              ),
            )),
      ),
    );
  }

}