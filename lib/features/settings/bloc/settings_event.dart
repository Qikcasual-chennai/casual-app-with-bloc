
part of 'settings_bloc.dart';

abstract class SettingsEvent{}

class UpdatePasswordEvent extends SettingsEvent{
  final CasualPasswordModel casualPasswordModel;

  UpdatePasswordEvent({required this.casualPasswordModel});
}