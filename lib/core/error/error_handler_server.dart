import 'package:dio/dio.dart';
import 'package:grocery_app/core/error/error_message_model.dart';
import 'package:grocery_app/core/error/failure.dart';
import 'package:grocery_app/core/error/string_error.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unAuthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultData,
}

class ErrorHandlerServer implements Exception {
  late Failure failure;

  ErrorHandlerServer.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.defaultData.getFailure();
    }
  }

  Failure _handleError(DioException error) {
    // if (error.isNoConnectionError) {
    //   return DataSource.noInternetConnection.getFailure();
    // } else {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.connectTimeout.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case ResponseCode.badRequest:
            return DataSource.badRequest.getFailure();
          case ResponseCode.forbidden:
            return DataSource.forbidden.getFailure();
          case ResponseCode.unAuthorized:
            return DataSource.unAuthorized.getFailure();
          case ResponseCode.notFound:
            return DataSource.notFound.getFailure(
                errorMessage: ErrorMessageModel.fromJson(error.response!.data));
          case ResponseCode.internalServerError:
            return DataSource.internalServerError.getFailure();
          case ResponseCode.noContent:
            return DataSource.noContent.getFailure();
          default:
            return DataSource.defaultData.getFailure();
        }
      case DioExceptionType.cancel:
        return DataSource.cancel.getFailure();
      case DioExceptionType.unknown:
        return DataSource.defaultData.getFailure();
      default:
        return DataSource.defaultData.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure({ErrorMessageModel? errorMessage}) {
    switch (this) {
      case DataSource.badRequest:
        return const ServerFailure(
          message: ResponseMessage.badRequest,
        );
      case DataSource.forbidden:
        return const ServerFailure(
          message: ResponseMessage.forbidden,
        );
      case DataSource.unAuthorized:
        return const ServerFailure(
          message: ResponseMessage.unAuthorized,
        );
      case DataSource.notFound:
        return ServerFailure(
          message: errorMessage!.statusMessage,
        );
      case DataSource.internalServerError:
        return const ServerFailure(
          message: ResponseMessage.internalServerError,
        );
      case DataSource.connectTimeout:
        return const ServerFailure(
          message: ResponseMessage.connectTimeout,
        );
      case DataSource.cancel:
        return const ServerFailure(
          message: ResponseMessage.cancel,
        );
      case DataSource.receiveTimeout:
        return const ServerFailure(
          message: ResponseMessage.receiveTimeout,
        );
      case DataSource.sendTimeout:
        return const ServerFailure(
          message: ResponseMessage.sendTimeout,
        );
      case DataSource.cacheError:
        return const ServerFailure(
          message: ResponseMessage.cacheError,
        );
      case DataSource.noInternetConnection:
        return const ServerFailure(
          message: ResponseMessage.noInternetConnection,
        );
      case DataSource.noContent:
        return const ServerFailure(
          message: ResponseMessage.noContent,
        );
      case DataSource.defaultData:
        return const ServerFailure(
          message: ResponseMessage.defaultData,
        );
      default:
        return const ServerFailure(
          message: ResponseMessage.defaultData,
        );
    }
  }
}

class ResponseCode {
  // API status codes
  static const int success = 200; // success with data
  static const int noContent = 204; // success with no content
  static const int badRequest = 400; // failure, api rejected the request
  static const int forbidden = 403; // failure, api rejected the request
  static const int unAuthorized = 401; // failure user is not authorised
  static const int notFound =
      404; // failure, api url is not correct and not found
  static const int internalServerError =
      500; // failure, crash happened in server side

  // local status code
  static const int defaultData = -1;
  static const int connectTimeout = -2;
  static const int cancel = -3;
  static const int receiveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}

class ResponseMessage {
  // API status codes
  // API response codes
  static const String success =
      AppStringsErrorServer.success; // success with data
  static const String noContent =
      AppStringsErrorServer.noContent; // success with no content
  static const String badRequest = AppStringsErrorServer
      .badRequestError; // failure, api rejected our request
  static const String forbidden = AppStringsErrorServer
      .forbiddenError; // failure,  api rejected our request
  static const String unAuthorized = AppStringsErrorServer
      .unauthorizedError; // failure, user is not Authorized
  static const String notFound = AppStringsErrorServer
      .notFoundError; // failure, API url is not correct and not found in api side.
  static const String internalServerError = AppStringsErrorServer
      .internalServerError; // failure, a crash happened in API side.

  // local responses codes
  static const String defaultData =
      AppStringsErrorServer.defaultError; // unknown error happened
  static const String connectTimeout =
      AppStringsErrorServer.timeoutError; // issue in connectivity
  static const String cancel =
      AppStringsErrorServer.cacheError; // API request was cancelled
  static const String receiveTimeout =
      AppStringsErrorServer.timeoutError; //  issue in connectivity
  static const String sendTimeout =
      AppStringsErrorServer.timeoutError; //  issue in connectivity
  static const String cacheError = AppStringsErrorServer
      .defaultError; //  issue in getting data from local data source (cache)
  static const String noInternetConnection =
      AppStringsErrorServer.noInternetError; // issue in connectivity
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
