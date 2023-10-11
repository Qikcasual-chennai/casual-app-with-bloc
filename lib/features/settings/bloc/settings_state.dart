
part of 'settings_bloc.dart';

abstract class SettingsState{}

abstract class SettingsActionState extends SettingsState{}

class SettingsInitials extends SettingsState{}

class SettingsLoadingState extends SettingsState{}

class ChangePasswordState extends SettingsActionState{
  final CasualPasswordModel casualPasswordModel;
  final Map<String, dynamic> errors;

  ChangePasswordState({required this.casualPasswordModel, required this.errors});
}

class ChangePasswordSuccessState extends SettingsActionState{
  final String msg;

  ChangePasswordSuccessState({required this.msg});
}

class SettingsApiTokenExpired extends SettingsActionState{
  final String msg;

  SettingsApiTokenExpired({required this.msg});
}

class SettingsDataNotifyState extends SettingsActionState{
  final String msg;

  SettingsDataNotifyState({required this.msg});
}




