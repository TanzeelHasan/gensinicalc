part of 'result_bloc.dart';

abstract class ResultEvent {}

class AddLesionScoreEvent extends ResultEvent {
  final double score;
  AddLesionScoreEvent(this.score);
}

class CalculateTotalEvent extends ResultEvent {}

