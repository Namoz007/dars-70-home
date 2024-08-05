import 'dart:convert';
import 'package:dars_70_home/data/models/card.dart';
import 'package:dars_70_home/data/models/check.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CardServices{
  final _api = "https://online-bank-785ca-default-rtdb.firebaseio.com/users";

  Future<void> addCard(CardModel model) async{
    final pref = await SharedPreferences.getInstance();
    String name = await pref.getString('name').toString();
    final response = await http.get(Uri.parse("${_api}.json"));
    Map<String,dynamic> mp = jsonDecode(response.body) as Map<String,dynamic>;
    List<String> keys = mp.keys.toList();
    String id = '';
    for(int i = 0;i < keys.length;i++) {
      if(mp[keys[i]]['fullName'] == name){
        id = keys[i];
      }
    }
    final data = await http.post(Uri.parse("$_api/${id}/cards.json"),body: jsonEncode(model.toJson()));
  }

  Future<List<CardModel>> getAllMyCards() async{
    List<CardModel> _cards = [];
    final pref = await SharedPreferences.getInstance();
    String name = pref.getString('name').toString();
    final response = await http.get(Uri.parse("${_api}.json"));
    Map<String,dynamic> mp = jsonDecode(response.body) as Map<String,dynamic>;
    List<String> keys = mp.keys.toList();
    String id = '';
    for(int i = 0;i < keys.length;i++) {
      if(mp[keys[i]]['fullName'] == name){
        id = keys[i];
        print("bu id $id");
      }
    }
    final data = await http.get(Uri.parse("$_api/${id}/cards.json"),);
    print('bu data ${data.body}');
    if(data.body != null && data.body != 'null'){
      Map<String,dynamic> mpp = jsonDecode(data.body) as Map<String,dynamic>;
      List<String> keyss = mpp.keys.toList();
      final a = CardModel.fromJson(mpp[keyss[0]]);
      for(int i = 0;i < keyss.length;i++){
        _cards.add(CardModel.fromJson(mpp[keyss[i]]));
      }
    }
    return _cards;
  }

  Future<List<CardModel>> getAllCards() async{
    List<CardModel> _cards = [];
    final response = await http.get(Uri.parse("${_api}.json"));
    if(response.body != null && response.body != 'null'){
      Map<String,dynamic> mp = jsonDecode(response.body) as Map<String,dynamic>;
      List<String> keys = mp.keys.toList();
      for(int i = 0;i < keys.length;i++){
        if(mp[keys[i]]['cards'] != null){
          Map<String,dynamic> cards = mp[keys[i]]['cards'];
          List<String> cardsKeys = cards.keys.toList();
          for(int j = 0;j < cardsKeys.length;j++){
            _cards.add(CardModel.fromJson(mp[keys[i]]['cards'][cardsKeys[j]]));
          }
        }
      }
    }
    return _cards;
  }

  Future<void> paymentToCard(Check check) async{
    List<CardModel> _cards = [];
    final response = await http.get(Uri.parse("${_api}.json"));
    if(response.body != null && response.body != 'null'){
      Map<String,dynamic> mp = jsonDecode(response.body) as Map<String,dynamic>;
      List<String> keys = mp.keys.toList();
      Map<String,String> sendCardId = {};
      Map<String,String> acceptCardId = {};
      for(int i = 0;i < keys.length;i++){
        if(mp[keys[i]]['cards'] != null){
          Map<String,dynamic> cards = mp[keys[i]]['cards'];
          List<String> cardsKeys = cards.keys.toList();
          for(int j = 0;j < cardsKeys.length;j++){
            if(check.sendCard.toString().contains(mp[keys[i]]['cards'][cardsKeys[j]]['number'])){
              sendCardId['userId'] = keys[i];
              sendCardId['cardId'] = cardsKeys[j];
            }else if(check.acceptCard.toString().contains(mp[keys[i]]['cards'][cardsKeys[j]]['number'])){
              acceptCardId['userId'] = keys[i];
              acceptCardId['cardId'] = cardsKeys[j];
            }
          }
        }
      }
      final updateBalance = await http.get(Uri.parse("$_api/${sendCardId['userId']}/cards/${sendCardId['cardId']}.json"),);
      await http.patch(Uri.parse("$_api/${sendCardId['userId']}/cards/${sendCardId['cardId']}.json"),body: jsonEncode({
        "balance": double.parse(jsonDecode(updateBalance.body)['balance'].toString()) - check.sum
      }));
      await http.post(Uri.parse("$_api/${sendCardId['userId']}/checks.json"),body: jsonEncode(check.toMap()));
      //---------------------------------------------
      final acceptCard = await http.get(Uri.parse("$_api/${acceptCardId['userId']}/cards/${acceptCardId['cardId']}.json"),);
      await http.patch(Uri.parse("$_api/${acceptCardId['userId']}/cards/${acceptCardId['cardId']}.json"),body: jsonEncode({
        "balance": double.parse(jsonDecode(acceptCard.body)['balance'].toString()) + check.sum
      }));
      await http.post(Uri.parse("$_api/${acceptCardId['userId']}/checks.json"),body: jsonEncode(check.toMap()));
    }
  }

  Future<List<Check>> getAllMyCheck() async{
    List<Check> _checks = [];
    final pref = await SharedPreferences.getInstance();
    String name = await pref.getString('name').toString();
    final response = await http.get(Uri.parse("${_api}.json"));
    Map<String,dynamic> mp = jsonDecode(response.body) as Map<String,dynamic>;
    List<String> keys = mp.keys.toList();
    String id = '';
    for(int i = 0;i < keys.length;i++) {
      if(mp[keys[i]]['fullName'] == name){
        id = keys[i];
      }
    }
    final data = await http.get(Uri.parse("$_api/${id}/checks.json"),);
    if(data.body != null && data.body != 'null'){
      Map<String,dynamic> mpp = jsonDecode(data.body) as Map<String,dynamic>;
      List<String> keyss = mpp.keys.toList();
      for(int i = 0;i < keyss.length;i++){
        _checks.add(Check.fromJson(mpp[keyss[i]]));
      }
    }
    return _checks;
  }
}