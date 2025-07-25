import 'package:flutter_bloc/flutter_bloc.dart';

part 'result_event.dart';
part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  ResultBloc() : super(ResultState()) {
    on<AddLesionScoreEvent>((event, emit) {
      final updatedScores = [...state.lesionScores, event.score];
      final total = updatedScores.reduce((a, b) => a + b);
      emit(state.copyWith(lesionScores: updatedScores, totalScore: total));
    });

    on<CalculateTotalEvent>((event, emit) {
      final total = state.lesionScores.reduce((a, b) => a + b);
      emit(state.copyWith(totalScore: total));
    });
  }
}