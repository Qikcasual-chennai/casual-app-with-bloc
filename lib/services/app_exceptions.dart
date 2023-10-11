class AppException implements Exception{
  final String? message;
  final String? prefix;
  final String? url;

  AppException(this.message, this.prefix, this.url);

}

class BadRequestException extends AppException{
  BadRequestException([String? message, String? url]) : super(message, 'Bad Request', url);
}

class FetchDataException extends AppException{
  FetchDataException([String? message, String? url]) : super(message, 'Unable to process', url);
}

class UnAuthorizedException extends AppException{
  UnAuthorizedException([String? message, String? url]) : super(message, 'UnAuthorized request', url);
}

class InvalidInputException extends AppException{
  InvalidInputException([String? message, String? url]) : super(message, 'Invalid Input : ', url);
}

class ApiNotRespondingException extends AppException{
  ApiNotRespondingException([String? message, String? url]) : super(message, 'Api not responded in time', url);
}