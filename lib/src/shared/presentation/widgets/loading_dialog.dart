import 'package:flutter/material.dart';

import 'custom_progress_indicator.dart';

class LoadingShowDialog {

  static void show(BuildContext context, [String message = 'Cargando...']) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) =>
            AlertDialog(
              backgroundColor: Colors.white,
              //Theme
              //    .of(dialogContext)
              //    .scaffoldBackgroundColor,
              content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    const CustomCircularProgressBar(),
                    const SizedBox(height: 18),
                    Text(message, style: Theme
                        .of(dialogContext)
                        .textTheme
                        .titleMedium,),
                  ]
              ),
            ));
  }
}
