
part of 'auth_bloc.dart';

@immutable
abstract class AuthState{}

abstract class AuthActionState extends AuthState{}

class InitialState extends AuthState{}
class LoadingState extends AuthState{}

class LoginErrorState extends AuthState{
  final Map<String, dynamic> errors;

  LoginErrorState({required this.errors});
}

class LoginState extends AuthState{
  final CasualModel casualModel;
  final Map<String, dynamic> errors;
  LoginState({required this.casualModel, required this.errors});
}

class HomeNavigateActionState extends AuthActionState{
  final String msg;

  HomeNavigateActionState({required this.msg});
}

class UnAuthorizedState extends AuthActionState{
  final String msg;

  UnAuthorizedState(this.msg);
}
