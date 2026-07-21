class AppExceptions implements Exception {
  final String? message;
  final String? prefix;
  AppExceptions([this.message, this.prefix]);

  @override
  String toString() {
    final msg = message?.trim() ?? '';
    if (msg.isNotEmpty) return msg;
    return '${prefix ?? ''}';
  }
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class ValidationException extends AppExceptions {
  ValidationException([String? message])
      : super(message, "One or more validation erorr");
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? message]) : super(message, "Invalid Request: ");
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException([String? message])
      : super(message, "Unauthorized Request: ");
}

class NotFoundException extends AppExceptions {
  NotFoundException([String? message]) : super(message, "Not Found: ");
}

class InvalidInputException extends AppExceptions {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class InternalServerException extends AppExceptions {
  InternalServerException([String? message])
      : super(message, "Internal Server Error: ");
}

class ConflictException extends AppExceptions {
  ConflictException([String? message]) : super(message, "Conflict: ");
}

class NoInternetException extends AppExceptions {
  NoInternetException([String? message]) : super(message, "No Internet: ");
}

class UnknownException extends AppExceptions {
  UnknownException([String? message]) : super(message, "Unknown Error: ");
}

class ServerException extends AppExceptions {
  ServerException([String? message]) : super(message, "Server Error: ");
}

class CacheException extends AppExceptions {
  CacheException([String? message]) : super(message, "Cache Error: ");
}

class NoDataException extends AppExceptions {
  NoDataException([String? message]) : super(message, "No Data: ");
}

class RequestTimeoutException extends AppExceptions {
  RequestTimeoutException([String? message])
      : super(message, "Request Timeout: ");
}
