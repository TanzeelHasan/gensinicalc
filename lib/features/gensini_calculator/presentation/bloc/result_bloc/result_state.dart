part of 'result_bloc.dart';

class ResultState {
  final double totalScore;
  final List<double> lesionScores;

  ResultState({
    this.totalScore = 0,
    this.lesionScores = const [],
  });

  ResultState copyWith({
    double? totalScore,
    List<double>? lesionScores,
  }) {
    return ResultState(
      totalScore: totalScore ?? this.totalScore,
      lesionScores: lesionScores ?? this.lesionScores,
    );
  }
}
