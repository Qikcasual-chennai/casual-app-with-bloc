part of 'city_bloc.dart';

@immutable
abstract class CityState{}

abstract class CityActionState extends CityState{}

class CityLoadingState extends CityState{}

// class UnAuthorizedState extends CityActionState{
//   final String msg;
//
//   UnAuthorizedState({required this.msg});
// }

class AllCitiesState extends CityState{
  final List<CityModel> cities;

  AllCitiesState({required this.cities});
}

class getCityState extends CityState{
  final CityModel cityModel;

  getCityState({required this.cityModel});
}