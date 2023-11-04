import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tmdbassignment/bloc/movies_detail_bloc/movies_detail_bloc.dart';
import 'package:tmdbassignment/bottom_navigator/navigation_page.dart';
import 'package:tmdbassignment/consts/consts.dart';
import 'package:tmdbassignment/debug/bloc_observer.dart';
import 'package:tmdbassignment/repositories/movies_detail_repo.dart';
import 'package:tmdbassignment/repositories/movies_repo.dart';

import 'bloc/movies_bloc/movies_bloc.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  Bloc.observer = MyBlocObserver();
  runApp(MultiRepositoryProvider(providers: [
    RepositoryProvider(create: (context)=>MoviesRepo()),
    RepositoryProvider(create: (context)=>MoviesDetailRepo()),
  ],
  child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.




  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(create: (context) => MoviesBloc(MoviesRepo())),
        BlocProvider(create: (context) => MoviesDetailBloc(MoviesDetailRepo()))
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ten Twenty',
        theme: ThemeData(
          fontFamily: poppins,
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
        ),
        home: const BottomNavigationPage(),
      ),
    );
  }
}

