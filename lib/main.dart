import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morse_web_play/models/colors.dart';
import 'package:morse_web_play/providers/theme_provider.dart';
import 'package:morse_web_play/screens/platform_decider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'DotDash',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: const PlatformDecider(),
    );
  }
}

class Consts {
  static final Uri projectUrl = Uri.parse(
    'https://github.com/jydv402/morse_web_play',
  );
}
