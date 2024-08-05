import 'package:dars_70_home/data/models/card.dart';

import '../../data/models/check.dart';

sealed class CardState{}

final class InitialCardState extends CardState{}

final class LoadingCardState extends CardState{}

final class LoadedCardState extends CardState{
  List<CardModel> cards;


  LoadedCardState(this.cards);
}

final class GetAllMyChecksCardState extends CardState{
  List<Check> checks;

  GetAllMyChecksCardState(this.checks);
}

final class ErrorCardState extends CardState{
  String message;

  ErrorCardState(this.message);
}