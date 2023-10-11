

import 'dart:io';

import 'package:casual_app/constants/global_variables.dart';
import 'package:casual_app/models/casual/casual_model.dart';
import 'package:casual_app/services/app_exceptions.dart';
import 'package:casual_app/services/base_client.dart';

class AccountRepo{

  Future<dynamic> getProfile() async {
    var url = Uri.parse("${baseUrl}casual/profile");
    var result = await BaseClient().get(baseUrl, "casual/profile").catchError((error) {
      if(error is BadRequestException){
        print(error.message);
      }
      print(error);
    });
    return result;
  }

  Future<dynamic> updateProfile(CasualModel casualModel, File? image) async {
    var result = await BaseClient().putFormData(baseUrl, "casual/updateMe", casualModel, image).catchError((error) {
      if(error is BadRequestException){
        print(error.message);
      }
      print(error);
    });
    // print("error");
    // print(result);

    return result;
  }

}