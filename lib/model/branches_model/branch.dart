// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'branch.freezed.dart';
part 'branch.g.dart';

@freezed
class Branch with _$Branch {
  factory Branch({
    @JsonKey(name: 'struct_id') int? structId,
    @JsonKey(name: 'struct_name') String? structName,
    @JsonKey(name: 'struct_name_ar') String? structNameAr,
    bool? selected,
  }) = _Branch;

  factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);
}
