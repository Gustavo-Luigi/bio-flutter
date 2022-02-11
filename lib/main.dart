import 'package:bio_flutter/providers/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:provider/provider.dart';
import 'package:bio_flutter/bottom_nav_bar.dart';
import 'package:bio_flutter/providers/screen_provider.dart';
import 'package:bio_flutter/providers/measurement_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MeasurementProvider()),
        ChangeNotifierProvider(create: (_) => ScreenProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
      ],
      child: MaterialApp(
        title: 'Bio Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
          Locale('pt', ''),
          Locale('en', ''),
        ],
        home: const BottomNavBar(),
      ),
    );
  }
}
