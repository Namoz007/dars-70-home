import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:dars_70_home/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;
  final _api = "https://online-bank-785ca-default-rtdb.firebaseio.com/users";

  Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      final response = await http.get(Uri.parse("${_api}.json"));
      if(response.body != null && response.body != 'null'){
        Map<String,dynamic> mp = jsonDecode(response.body) as Map<String,dynamic>;
        List<String> keys = mp.keys.toList();
        for(int i = 0;i < keys.length;i++){
          if(mp[keys[i]]['email'] == email){
            final pref = await SharedPreferences.getInstance();
            pref.setString("name", mp[keys[i]]['fullName']);
          }
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> registration(
      String email, String password, String fullName) async {
    final pref = await SharedPreferences.getInstance();
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final model = UserModel(fullName: fullName, cards: [], checks: [],email: email);
      final data = await http.post(Uri.parse("https://online-bank-785ca-default-rtdb.firebaseio.com/users.json"),body: jsonEncode(model.toMap(model)));
      await pref.setString("name", fullName);
      return true;
    } catch (e) {
      return false;
    }
  }
}
