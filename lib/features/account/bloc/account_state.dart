

part of 'account_bloc.dart';

@immutable
abstract class AccountState{}

abstract class AccountActionState extends AccountState{}

class InitialsAccountState extends AccountState{}

class LoadingState extends AccountState{}

class GetProfileState extends AccountState{
  final CasualModel casualModel;

  GetProfileState({required this.casualModel});
}

class UnAuthorizedState extends AccountActionState{
  final String msg;

  UnAuthorizedState({required this.msg});
}

class ProfileUpdateState extends AccountState{
  final CasualModel casualModel;
  final Map<String, dynamic> errors;

  ProfileUpdateState({required this.casualModel,required this.errors});
}

class ProfileUpdateSuccessState extends AccountActionState{
  final String msg;

  ProfileUpdateSuccessState({required this.msg});
}