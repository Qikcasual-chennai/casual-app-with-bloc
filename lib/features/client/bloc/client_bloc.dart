import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:casual_app/features/client/repos/client_repo.dart';
import 'package:casual_app/models/client/client_model.dart';
import 'package:flutter/material.dart';

part 'client_state.dart';
part 'client_event.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState>{

  ClientRepo clientRepo = ClientRepo();
  List<ClientModel> clients = <ClientModel>[];

  ClientBloc() : super(ClientInitials()){
    on<GetAllClientsEvent>(getAllClientsEvent);
  }


  FutureOr<void> getAllClientsEvent(GetAllClientsEvent event, Emitter<ClientState> emit) async {
    emit(ClientLoadingState());
    clients = [];

    var result = await clientRepo.getAllClients();

    if(result['status']){
      result['clients'].forEach((client){
       clients.add(ClientModel.fromJson(client));
      });
      emit(GetAllClientsState(clients: clients));
    }else{

    }

  }
}