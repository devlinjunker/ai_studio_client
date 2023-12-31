import 'package:ai_studio_client/screens/EraSelectPage.dart';
import 'package:ai_studio_client/screens/MovieHallPage.dart';
import 'package:ai_studio_client/screens/MovieProductionPage.dart';
import 'package:ai_studio_client/screens/MovieSelectPage.dart';
import 'package:ai_studio_client/screens/PerformerSelectPage.dart';
import 'package:ai_studio_client/screens/DistributorSelectPage.dart';
import 'package:ai_studio_client/store/GameState.dart';
import 'package:ai_studio_client/store/StudioState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AppScheme.dart';
import 'screens/IntroPage.dart';
import 'screens/ProducerInfoPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<GameState>(create: (context) => GameState()),
          ChangeNotifierProvider<StudioState>(
              create: (context) => StudioState())
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              scaffoldBackgroundColor: AppScheme.background,
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              colorScheme: AppScheme,
            ),
            routes: {
              '/': (context) => const IntroPage(title: 'AI Movie Studio'),
              '/era': (context) => const EraSelectPage(),
              '/producer': (context) => const ProducerInfoPage(),
              '/movies': (context) => const MovieSelectPage(),
              '/distributor': (context) => const DistributorSelectPage(),
              '/performers': (context) => const PerformerSelectPage(),
              '/production': (context) => const MovieProductionPage(),
              '/movie-hall': (context) => const MovieHallPage(),
            }));
  }
}
