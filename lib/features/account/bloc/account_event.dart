
part of 'account_bloc.dart';

@immutable
abstract class AccountEvent {}

class GetProfileEvent extends AccountEvent{
}

class UpdateProfileEvent extends AccountEvent{
  final CasualModel casualModel;
  File? image;

  UpdateProfileEvent(this.image, {required this.casualModel});
}

