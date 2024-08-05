sealed class AuthEvent{}

final class InputedLoginAndPasswordAuthEvent extends AuthEvent{
  String login;
  String password;

  InputedLoginAndPasswordAuthEvent({required this.login,required this.password,});
}

final class RegistrationLoginAndPasswordAuthEvent extends AuthEvent{
  String login;
  String password;
  String fullName;

  RegistrationLoginAndPasswordAuthEvent({required this.login,required this.password,required this.fullName,});
}

final class ResetPasswordAuthEvent extends AuthEvent{
  String email;

  ResetPasswordAuthEvent(this.email);
}