import 'package:dars_70_home/services/auth_services.dart';

class AuthRepositories{
  final AuthServices _services;

  AuthRepositories({required AuthServices servic,}) : _services = servic;

  Future<bool> login(String email,String password) async{
    return await _services.login(email, password);
  }

  Future<bool> registration(String email,String password,String fullName) async{
    return await _services.registration(email, password,fullName);
  }
}