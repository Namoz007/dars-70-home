sealed class AuthState{}

final class InputLoginAndPasswordAuthState extends AuthState{}

final class LoadingAuthState extends AuthState{}

final class LoadedAuthState extends AuthState{}

final class ErrorAuthState extends AuthState{
  String message;

  ErrorAuthState(this.message);
}