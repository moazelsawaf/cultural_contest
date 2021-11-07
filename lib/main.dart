import 'package:cultural_contest/providers/quiz_provider.dart';
import 'package:cultural_contest/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => QuizProvider()),
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
      ],
      title: 'Material App',
      theme: ThemeData(
        fontFamily: 'Cairo',
        backgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
    );
  }
}
