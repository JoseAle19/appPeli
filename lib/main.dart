// ignore_for_file: use_key_in_widget_constructors

import 'package:aplicacion_peliculas/providers/movies_provider.dart';
import 'package:aplicacion_peliculas/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
          lazy: false,
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final pro = Provider.of<MoviesProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: "homescreen",
      routes: {
        "homescreen": (_) => const HomeScreenScreen(),
        "detailscreen": (_) => const DetailScreenScreen(),
      },
      theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(color: Colors.lightBlueAccent)),
    );
  }
}
