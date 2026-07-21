import 'package:freezed_annotation/freezed_annotation.dart';

import 'data.dart';

part 'branches_model.freezed.dart';
part 'branches_model.g.dart';

@freezed
class BranchesModel with _$BranchesModel {
  factory BranchesModel({
    bool? success,
    String? message,
    Data? data,
  }) = _BranchesModel;

  factory BranchesModel.fromJson(Map<String, dynamic> json) =>
      _$BranchesModelFromJson(json);
}
