import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto_topicos/firebase_options.dart';
import 'package:projeto_topicos/src/services/shared_preferences_service.dart';
import 'package:projeto_topicos/src/viewmodels/upload_view_model.dart';
import 'package:projeto_topicos/src/views/upload_database_screen.dart';
import 'package:provider/provider.dart';
import 'src/viewmodels/sql_view_model.dart';
import 'src/views/input_screen.dart';

Future<void> main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SQLViewModel(prefsService: SharedPreferencesService()),
        ),
        ChangeNotifierProvider(create: (_) => UploadViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto Tópicos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const UploadDatabaseScreen(),
    );
  }
}
