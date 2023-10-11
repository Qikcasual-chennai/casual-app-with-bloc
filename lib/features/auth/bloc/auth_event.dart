
part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent{
  final CasualModel casualModel;

  LoginEvent({required this.casualModel});
}