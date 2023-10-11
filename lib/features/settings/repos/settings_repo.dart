


import 'package:casual_app/constants/global_variables.dart';
import 'package:casual_app/models/casual/casual_password_model.dart';
import 'package:casual_app/services/base_client.dart';

class SettingsRepo{

  Future<dynamic> updatePassword(CasualPasswordModel casualPasswordModel) async{
    var result = await BaseClient().patch(baseUrl, "casual/update-password", casualPasswordModel).catchError((error){
      print(error);
      print("error");
    });

    print(result);
    return result;
  }
}