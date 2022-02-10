import 'package:bio_flutter/providers/screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotEnoughMeasurements extends StatelessWidget {
  const NotEnoughMeasurements({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Nada para mostrar, insira mais medições!'),
        ElevatedButton(
          onPressed: () {
            Provider.of<ScreenProvider>(context, listen: false).selectedScreen =
                Screen.form;
          },
          child: const Text('Inserir nova medição!'),
        )
      ]),
    );
  }
}
