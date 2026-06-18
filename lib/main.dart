import 'package:dismissible_project/features/AddNote/add_note.dart';
import 'package:dismissible_project/features/HomeScreen/HomeCubit/cubitt.dart';
import 'package:dismissible_project/features/HomeScreen/home_screen.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
void main() {
  runApp(

    BlocProvider(
      create: (context) => NotesCubit(), 
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
    );
  }
}