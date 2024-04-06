import 'package:flutter/material.dart';
import 'package:image_generator/features/prompt/ui/prompt_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.cyan, brightness: Brightness.dark),
        scaffoldBackgroundColor: Colors.grey.shade900,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.grey.shade900,
          elevation: 0,
        ),
      ),
      home: const PromptScreen(),
    );
  }
  // vk-XFHwIMfJyvxtn3g6t3CIDPS1LRty9hEv5MDFOo7FjfP6C
}
