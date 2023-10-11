import 'dart:convert';

import 'package:http/http.dart' as http ;

class ExceptionHandlers {
  processResponse(http.Response response){
    // print(json.decode(response.body.toString()));
    switch(response.statusCode){
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        break;
      case 401:
        var responseJson = json.decode(response.body.toString());
        return {...responseJson, "token":"Expired"};
      case 403:
        break;
      case 422:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 500:
      default:

    }
  }
}