import 'package:bio_flutter/screens/form_screen.dart';
import 'package:bio_flutter/screens/measurements_screen.dart';
import 'package:bio_flutter/widgets/measurement_form.dart';
import 'package:flutter/material.dart';

// Pages

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case FormScreen.routeName:
        return MaterialPageRoute(builder: (_) => const FormScreen());
      case MeasureMentScreen.routeName:
        return MaterialPageRoute(builder: (_) => const MeasureMentScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Erro'),
        ),
        body: const Center(
          child: Text('Erro'),
        ),
      );
    });
  }
}
