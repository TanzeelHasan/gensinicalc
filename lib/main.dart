import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gensinicalc/features/gensini_calculator/presentation/bloc/result_bloc/result_bloc.dart';
import 'package:gensinicalc/routes/routes.dart';

void main() {
  runApp(BlocProvider(create: (context) => ResultBloc(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Gensini Calculator',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
      ),
    );
  }
}
