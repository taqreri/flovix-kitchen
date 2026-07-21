// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BranchImpl _$$BranchImplFromJson(Map<String, dynamic> json) => _$BranchImpl(
      structId: (json['struct_id'] as num?)?.toInt(),
      structName: json['struct_name'] as String?,
      structNameAr: json['struct_name_ar'] as String?,
      selected: json['selected'] as bool?,
    );

Map<String, dynamic> _$$BranchImplToJson(_$BranchImpl instance) =>
    <String, dynamic>{
      'struct_id': instance.structId,
      'struct_name': instance.structName,
      'struct_name_ar': instance.structNameAr,
      'selected': instance.selected,
    };
