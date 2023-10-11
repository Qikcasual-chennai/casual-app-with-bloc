import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:casual_app/models/casual/casual_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_exceptions.dart';
import 'exception_handlers.dart';

class BaseClient {
  static const int TIME_OUT_DURATION = 20;

  getHeaders() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Authorization": "Bearer $token"
    };

    return headers;
  }

  getFormHeaders() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Authorization": "Bearer $token"
    };

    return headers;
  }

  //GET
  Future<dynamic> get(String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      // var response = await http.get(uri).timeout(const Duration(seconds: TIME_OUT_DURATION));
      // return _processResponse(response);
      var response = await http.get(uri, headers: await getHeaders());
      return ExceptionHandlers().processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }

  //POST
  Future<dynamic> post(String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    try {
      var response = await http.post(uri, body: payload, headers: await getHeaders());
      return ExceptionHandlers().processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }

  //POST By Query & Params
  Future<dynamic> postQueryId(String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = await http.post(uri, headers: await getHeaders());
      return ExceptionHandlers().processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }

  //PATCH
  Future<dynamic> patch(String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    try {
      var response = await http.patch(uri, body: payload, headers: await getHeaders());
      return ExceptionHandlers().processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }

  //PUT
  Future<dynamic> put(String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    try {
      var response = await http.put(uri, body: payload, headers: await getHeaders());
      return ExceptionHandlers().processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }

  Future<dynamic> putFormData(String baseUrl, String api, CasualModel casualModel, File? image) async {
    var uri = Uri.parse(baseUrl + api);

    try {
      var request = await http.MultipartRequest("PUT", uri);
      request.headers.addAll(await getFormHeaders());

      List<http.MultipartFile> newList = [];
      //PART 1
      // for(File file in images){
      //   print(file);
      //   var f = await http.MultipartFile.fromPath("casual_avatar", file.path, contentType: new MediaType("image", "jpg"));
      //   newList.add(f);
      // }
      //PART 2
      // for(var file in images){
      //   // print(file.runtimeType);
      //   File image = file['file'];
      //   // print(image);
      //   var f = await http.MultipartFile.fromPath(file['name'], image.path, contentType: new MediaType("image", "jpg"));
      //   newList.add(f);
      // }
      //FINAL
      // request.files.addAll(newList);

      if(image != null) {
        request.files.add(await http.MultipartFile.fromPath(
            "casual_avatar", image!.path,
            contentType: new MediaType("image", 'jpg')));
      }

      request.fields["casual_first_name"] = casualModel.casual_first_name!;
      request.fields["casual_last_name"] = casualModel.casual_last_name!;
      request.fields["casual_phone_no"] = casualModel.casual_phone_no!;
      request.fields["cityId"] = casualModel.cityId != null ? casualModel.cityId.toString() : null.toString();

      var streamedResponse = await request.send();
      // print("streamedResponse");
      // print(streamedResponse.stream);
      var response = await http.Response.fromStream(streamedResponse);
      // print("response");
      // print(response.statusCode);
      return ExceptionHandlers().processResponse(response);
    } on SocketException{
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }

  }

  //DELETE
  //OTHER

  dynamic _processResponse(http.Response response) {
    // print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 400:
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
      // print(response.request!.url.toString());
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException('Error Occured with code : ${response.statusCode}', response.request!.url.toString());
    }
  }
}