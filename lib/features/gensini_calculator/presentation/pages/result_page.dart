import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gensinicalc/features/gensini_calculator/presentation/bloc/result_bloc/result_bloc.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: BlocBuilder<ResultBloc, ResultState>(
        builder: (context, state) {
          return Center(
            child: Text(
              "Total Modified Gensini Score: ${state.totalScore}",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          );
        },
      ),
    );
  }
}
