import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/vitals_entry_screen.dart';
import 'services/vitals_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VitalsService(),
      child: MaterialApp(
        title: 'Clinical Vitals Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const VitalsEntryScreen(),
      ),
    );
  }
}
