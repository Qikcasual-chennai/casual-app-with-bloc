import 'package:casual_app/constants/global_variables.dart';
import 'package:casual_app/services/app_exceptions.dart';
import 'package:casual_app/services/base_client.dart';

class CityRepo{
  Future<dynamic> getAllCities() async {
    var url = Uri.parse("${baseUrl}city/allCities");
    var result = await BaseClient().get(baseUrl, "city/all-cities-from-server").catchError((error){
      if(error is BadRequestException){
        print(error.message);
      }
      print(error);
    });

    return result;
  }
}