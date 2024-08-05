import 'package:bloc/bloc.dart';
import 'package:dars_70_home/bloc/auth_bloc/auth_event.dart';
import 'package:dars_70_home/bloc/auth_bloc/auth_state.dart';
import 'package:dars_70_home/data/repositorys/auth_repositories.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  final AuthRepositories _repositories;

  AuthBloc({required AuthRepositories repo}) : _repositories = repo,super(InputLoginAndPasswordAuthState()){
   on<InputedLoginAndPasswordAuthEvent>(_login);
   on<RegistrationLoginAndPasswordAuthEvent>(_registration);
  }

  Future<void> _registration(RegistrationLoginAndPasswordAuthEvent event,emit) async{
    emit(LoadingAuthState());
    final data = await _repositories.registration(event.login, event.password,event.fullName);
    print("sorov yuborilib boldi");
    if(!data)
      emit(ErrorAuthState("user find"));
    else
      emit(ErrorAuthState(""));
  }

  Future<void> _login(InputedLoginAndPasswordAuthEvent event,emit) async{
    emit(LoadingAuthState());
    final data = await _repositories.login(event.login, event.password);
    if(!data)
      emit(ErrorAuthState("not user"));
    else
      emit(ErrorAuthState(""));
  }
  
}