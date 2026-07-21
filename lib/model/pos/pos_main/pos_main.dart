import 'package:freezed_annotation/freezed_annotation.dart';

import 'data.dart';

part 'pos_main.freezed.dart';
part 'pos_main.g.dart';

@freezed
class PosMain with _$PosMain {
  factory PosMain({
    bool? success,
    String? message,
    Data? data,
  }) = _PosMain;

  factory PosMain.fromJson(Map<String, dynamic> json) =>
      _$PosMainFromJson(json);
}
