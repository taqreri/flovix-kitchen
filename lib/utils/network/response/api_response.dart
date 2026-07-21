

import 'package:flovix_kitchen/utils/enums.dart';

class ApiResponse<T> {
  final Status status;
  final T? data;
  final String? message;

  // Private const constructor
  const ApiResponse._({
    required this.status,
    this.data,
    this.message,
  });

  // Default constructor (non-const)
  ApiResponse(this.status, this.data, this.message);

  // Initial state - CONST
  const ApiResponse.initial()
      : this._(status: Status.initial, data: null, message: null);

  // Loading state - CONST
  const ApiResponse.loading()
      : this._(status: Status.loading, data: null, message: null);

  // Completed state - CONST
  const ApiResponse.completed(T data)
      : this._(status: Status.completed, data: data, message: null);

  // Error state - CONST
  const ApiResponse.error(String message)
      : this._(status: Status.error, data: null, message: message);

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data: $data";
  }
}