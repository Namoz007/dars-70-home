import 'package:dars_70_home/data/models/card.dart';
import 'package:dars_70_home/data/models/check.dart';

class UserModel {
  String email;
  String fullName;
  List<CardModel> cards;
  List<Check> checks;

  UserModel({
    required this.email,
    required this.fullName,
    required this.cards,
    required this.checks,
  });

  factory UserModel.fromJson(Map<String, dynamic> mp) {
    return UserModel(
      email: mp['email'],
      fullName: mp['fullName'],
      cards: mp['cardModel'],
      checks: mp['checks'],
    );
  }

  Map<String,dynamic> toMap(UserModel model){
    return {
      "email": model.email,
      "fullName": model.fullName,
      "cardModel": model.cards,
      "checks": model.checks,
    };
  }
}
