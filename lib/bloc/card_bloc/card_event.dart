import 'package:dars_70_home/data/models/card.dart';
import 'package:dars_70_home/data/models/check.dart';

sealed class CardEvent{}

final class AddCardEvent extends CardEvent{
  CardModel model;

  AddCardEvent(this.model);
}

final class GetGlobalCardEvent extends CardEvent{}

final class GetAllCardEvent extends CardEvent{}

final class PaymentToCardEvent extends CardEvent{
  Check check;

  PaymentToCardEvent(this.check);
}

final class GetAllMyChecks extends CardEvent{}

final class GetLoading extends CardEvent{}