import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_agiles/pages/inicio_page.dart';
import 'package:project_agiles/services/auth_service.dart';
import 'package:project_agiles/services/chofer_service.dart';
import 'package:project_agiles/services/ruta_servive.dart';
import 'package:project_agiles/services/user_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AppProvider());
}

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(
          create: (_) => UserService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChoferService(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) => RutaService(),
          lazy: true,
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cootrancznorte',
      home: InicioPage(),
    );
  }
}
