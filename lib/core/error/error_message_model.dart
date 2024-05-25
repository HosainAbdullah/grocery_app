import 'dart:developer';

import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final int statusCode;
  final String statusMessage;

  const ErrorMessageModel({
    required this.statusCode,
    required this.statusMessage,
  });

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    return ErrorMessageModel(
      statusCode: json["status"],
      statusMessage: json["message"],
    );
  }

  @override
  List<Object?> get props => [
        statusCode,
        statusMessage,
      ];
}
