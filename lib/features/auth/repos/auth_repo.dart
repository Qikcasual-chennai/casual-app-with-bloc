import 'dart:async';

import 'package:casual_app/models/casual/casual_model.dart';
import 'package:casual_app/services/app_exceptions.dart';
import 'package:casual_app/services/base_client.dart';

import '../../../constants/global_variables.dart';


class AuthRepo {

  Future<dynamic> login(CasualModel casualModel) async {
    var url = Uri.parse("${baseUrl}casual/login");
    // print("${baseUrl}manager/login");

    var result = await BaseClient().post(baseUrl, "casual/login", casualModel).catchError((error){
      if(error is BadRequestException){
        print(error.message);
      }
      print(error);
    });
    // print(result);
    return result;
  }
}
