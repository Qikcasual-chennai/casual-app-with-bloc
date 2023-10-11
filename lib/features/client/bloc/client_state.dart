part of 'client_bloc.dart';

@immutable
abstract class ClientState{}

abstract class ClientActionState extends ClientState{}

class ClientInitials extends ClientState{}

class ClientLoadingState extends ClientState{}

class GetAllClientsState extends ClientState{
  final List<ClientModel> clients;

  GetAllClientsState({required this.clients});
}
