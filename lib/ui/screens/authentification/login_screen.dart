import 'package:dars_70_home/bloc/auth_bloc/auth_state.dart';
import 'package:dars_70_home/ui/screens/authentification/registration_screen.dart';
import 'package:dars_70_home/ui/screens/authentification/reset_password_for_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth_bloc/auth_bloc.dart';
import '../../../bloc/auth_bloc/auth_event.dart';
import 'login_textfields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _fromKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
              child: Form(
                key: _fromKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Tadbiro",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<AuthBloc,AuthState>(
                      builder: (context,state){
                        if(state is ErrorAuthState){
                          return Center(child: Text("${state.message}",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.red,),),);
                        }
                        
                        return Container();
                      },
                    ),
                    const SizedBox(height: 30,),
                    const Text(
                      "Tizimga kirish",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: LoginTextfield(
                        controller: _loginController,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: PasswordTextField(
                        controller: _passwordController,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          child: Text(
                            "Parolni tiklash",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (context) => ResetPasswordForDialog());
                          },
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () async {
                        if (_fromKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(InputedLoginAndPasswordAuthEvent(login: _loginController.text, password: _passwordController.text));
                        }
                      },
                      child: BlocBuilder<AuthBloc,AuthState>(
                        builder: (context,state){
                          if(state is LoadingAuthState){
                            return const Center(child: CircularProgressIndicator(color: Colors.red,),);
                          }

                          if(state is InputLoginAndPasswordAuthState || state is LoadedAuthState){
                            return InkWell(
                              onTap: (){
                                context.read<AuthBloc>().add(InputedLoginAndPasswordAuthEvent(login: _loginController.text, password: _passwordController.text));
                              },
                              child: Container(
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Kirish",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 22),
                                ),
                              ),
                            );
                          }

                          return Container();
                        },
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationScreen()));
                        },
                        child: Text(
                                "Ro'yxatdan o'tish",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.blue),
                              ),)
                  ],
                ),
              ),
            ),
    );
  }
}
