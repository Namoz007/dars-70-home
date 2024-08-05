import 'package:dars_70_home/bloc/auth_bloc/auth_event.dart';
import 'package:dars_70_home/bloc/auth_bloc/auth_state.dart';
import 'package:dars_70_home/ui/screens/authentification/login_textfields.dart';
import 'package:dars_70_home/ui/screens/authentification/registration_passwords.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth_bloc/auth_bloc.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _firstPasswordController = TextEditingController();
  final _secondPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  String? error;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100,),
                const Text("Tadbiro",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 45,),),
                const SizedBox(height: 20,),
                BlocBuilder<AuthBloc,AuthState>(builder: (context,state){
                  if(state is ErrorAuthState){
                    if(state.message == '')
                      Navigator.pop(context);
                    return Center(child: Text("${state.message}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.red,),),);
                  }
                  return Container();
                }),
                const SizedBox(height: 30,),
                const Text("Ro'yxatdan o'tish",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
        
                Padding(padding: const EdgeInsets.symmetric(horizontal: 30),child: LoginTextfield(controller: _loginController,),),
                const SizedBox(height: 20,),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 30),child: RegistrationPasswords(firstController: _firstPasswordController,secondController: _secondPasswordController,name: _nameController,),),
                const SizedBox(height: 30,),
        
                InkWell(
                  onTap: () async{
                    if(_formKey.currentState!.validate()){
                      context.read<AuthBloc>().add(RegistrationLoginAndPasswordAuthEvent(login: _loginController.text, password: _firstPasswordController.text,fullName: _nameController.text));
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 250,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.center,
                    child:  BlocBuilder<AuthBloc,AuthState>(
                      builder: (context,state){
                        if(state is LoadingAuthState){
                          return const Center(child: CircularProgressIndicator(color: Colors.red,),);
                        }
                        return const Text("Ro'yxatdan o'tish",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),);
                      },
                    )
                  ),
                ),
                InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: const Text("Tizimga kirish",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),))
        
              ],
            ),
          ),
        ),
      ),
    );
  }
}
