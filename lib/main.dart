import 'package:flutter/material.dart';
import 'package:quick_translate/services/services.dart';
import 'screen/screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ProviderService(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
