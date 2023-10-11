
import 'package:casual_app/constants/global_variables.dart';
import 'package:casual_app/services/app_exceptions.dart';
import 'package:casual_app/services/base_client.dart';

class ClientRepo{

  Future<dynamic> getAllClients(){
    var result = BaseClient().get(baseUrl, "client/all").catchError((error){
      if(error is BadRequestException){
        print(error.message);
      }
      print(error);
    });
    print(result);
    return result;
  }
}