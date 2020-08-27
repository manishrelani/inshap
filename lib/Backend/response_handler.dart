import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:inshape/data_models/result.dart';

class ResponseHandler {
  static Result<T> getResult<T>(Response response) {
    /// 200 - success
    /// 201 - created
    /// 400 - bad request
    /// 401 - unauthorized
    /// 403 - Forbidden
    /// 404 - Not Found
    /// 409 - Conflict
    /// 500 - Internal Server Error
    debugPrint('-----------------------Response---------------------');
    debugPrint(response.body);
    debugPrint('----------------------------------------------------');

    final decodedJson = json.decode(response.body);

    switch (response.statusCode) {
      case 200:
        return Result<T>.success(
          statusCode: 200,
          message: decodedJson['message'] ?? 'Success',
        );
      case 201:
        return Result<T>.success(
          statusCode: 201,
          message: decodedJson['message'] ?? 'Created',
        );
      case 400:
        return Result<T>.fail(
          statusCode: 400,
          message: decodedJson['message'] ?? 'Bad request',
        );
      case 401:
        return Result<T>.fail(
          statusCode: 401,
          message: decodedJson['message'] ?? 'Unauthorized',
        );
      case 403:
        return Result<T>.fail(
          statusCode: 403,
          message: decodedJson['message'] ?? 'Forbidden',
        );
      case 404:
        return Result<T>.fail(
          statusCode: 404,
          message: decodedJson['message'] ?? 'Not Found',
        );
      case 409:
        return Result<T>.fail(
          statusCode: 409,
          message: decodedJson['message'] ?? 'Conflict',
        );
      case 500:
        return Result<T>.internalServerError(
          message: decodedJson['message'] ?? 'Internal Server Error',
        );
      default:
        return Result<T>.fail(
          statusCode: response.statusCode,
          message: decodedJson['message'] ?? 'Something has gone wrong',
        );
    }
  }
}
