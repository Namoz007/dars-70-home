import 'package:dars_70_home/data/models/card.dart';
import 'package:dars_70_home/data/models/check.dart';

import '../../services/card_services.dart';

class CardRepositories{
  final CardServices _services;
  CardRepositories({required CardServices servic}) : _services = servic;

  Future<void> addCard(CardModel model) async{
    await _services.addCard(model);
  }

  Future<List<CardModel>> getAllMyCards() async{
    return await _services.getAllMyCards();
  }

  Future<void> paymentToCard(Check check) async{
    await _services.paymentToCard(check);
  }

  Future<List<CardModel>> getAllCards() async{
    return await _services.getAllCards();
  }

  Future<List<Check>> getAllMyChecks() async{
    return await _services.getAllMyCheck();
  }
}