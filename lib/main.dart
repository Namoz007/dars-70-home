import 'package:dars_70_home/bloc/auth_bloc/auth_bloc.dart';
import 'package:dars_70_home/bloc/card_bloc/card_bloc.dart';
import 'package:dars_70_home/data/repositorys/auth_repositories.dart';
import 'package:dars_70_home/data/repositorys/card_repositories.dart';
import 'package:dars_70_home/services/auth_services.dart';
import 'package:dars_70_home/services/card_services.dart';
import 'package:dars_70_home/ui/screens/authentification/login_screen.dart';
import 'package:dars_70_home/ui/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "name-here",
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _services = AuthServices();
  final _cardServices = CardServices();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepositories(servic: _services)),
        RepositoryProvider(create: (context) => CardRepositories(servic: _cardServices)),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(repo: context.read<AuthRepositories>())),
          BlocProvider(create: (context) => CardBloc(repo: context.read<CardRepositories>()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context,snapshot){
              print("stream ishlayapti");
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );
              }

              if (snapshot.hasError)
                return Center(
                  child: Text(
                    "Xatolik kelilb chiqdi",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                );
              print("snapshot malumot ${snapshot.data}");
              return snapshot.data == null ? LoginScreen() : HomeScreen();
            },
          )
        ),
      ),
    );
  }
}
