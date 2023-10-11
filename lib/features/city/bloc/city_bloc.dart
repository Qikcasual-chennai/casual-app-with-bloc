
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:casual_app/features/city/repos/city_repo.dart';
import 'package:casual_app/models/city/city_model.dart';
import 'package:flutter/material.dart';


part 'city_event.dart';
part 'city_state.dart';

class CityBLoc extends Bloc<CityEvent, CityState>{

  CityRepo cityRepo = CityRepo();
  final CityModel cityModel = CityModel();
  List<CityModel> cityLists = <CityModel>[];

  CityBLoc() : super (CityLoadingState()){
    on<GetAllCities>(getAllCities);
  }

  FutureOr<void> getAllCities(GetAllCities event, Emitter<CityState> emit) async {
    emit(CityLoadingState());
    var result = await cityRepo.getAllCities();
    cityLists = [];
    if(result['status']){
      // print(result['cities']);
      // emit(getCityState(cityModel: CityModel.fromJson(result['cities'][0])));
      result['cities'].forEach((city){
        // print(city);
        cityLists.add(CityModel.fromJson(city));
      });
      emit(AllCitiesState(cities: cityLists));
    }else{
      print(result);
      if(result["token"] == "Expired"){
        // emit(UnAuthorizedState(msg: result['message']));
      }
    }

  }
}