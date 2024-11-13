import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp/services/auth/auth_gate.dart';
import 'package:fyp/firebase_options.dart';
//import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    /*MultiProvider(
      providers: const [
        //shop provider
        //ChangeNotifierProvider(create: (context) => Shop()),
      ],
      child: const MyApp(),
    ),*/
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
