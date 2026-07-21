// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'branch.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Branch _$BranchFromJson(Map<String, dynamic> json) {
  return _Branch.fromJson(json);
}

/// @nodoc
mixin _$Branch {
  @JsonKey(name: 'struct_id')
  int? get structId => throw _privateConstructorUsedError;
  @JsonKey(name: 'struct_name')
  String? get structName => throw _privateConstructorUsedError;
  @JsonKey(name: 'struct_name_ar')
  String? get structNameAr => throw _privateConstructorUsedError;
  bool? get selected => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BranchCopyWith<Branch> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BranchCopyWith<$Res> {
  factory $BranchCopyWith(Branch value, $Res Function(Branch) then) =
      _$BranchCopyWithImpl<$Res, Branch>;
  @useResult
  $Res call(
      {@JsonKey(name: 'struct_id') int? structId,
      @JsonKey(name: 'struct_name') String? structName,
      @JsonKey(name: 'struct_name_ar') String? structNameAr,
      bool? selected});
}

/// @nodoc
class _$BranchCopyWithImpl<$Res, $Val extends Branch>
    implements $BranchCopyWith<$Res> {
  _$BranchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? structId = freezed,
    Object? structName = freezed,
    Object? structNameAr = freezed,
    Object? selected = freezed,
  }) {
    return _then(_value.copyWith(
      structId: freezed == structId
          ? _value.structId
          : structId // ignore: cast_nullable_to_non_nullable
              as int?,
      structName: freezed == structName
          ? _value.structName
          : structName // ignore: cast_nullable_to_non_nullable
              as String?,
      structNameAr: freezed == structNameAr
          ? _value.structNameAr
          : structNameAr // ignore: cast_nullable_to_non_nullable
              as String?,
      selected: freezed == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BranchImplCopyWith<$Res> implements $BranchCopyWith<$Res> {
  factory _$$BranchImplCopyWith(
          _$BranchImpl value, $Res Function(_$BranchImpl) then) =
      __$$BranchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'struct_id') int? structId,
      @JsonKey(name: 'struct_name') String? structName,
      @JsonKey(name: 'struct_name_ar') String? structNameAr,
      bool? selected});
}

/// @nodoc
class __$$BranchImplCopyWithImpl<$Res>
    extends _$BranchCopyWithImpl<$Res, _$BranchImpl>
    implements _$$BranchImplCopyWith<$Res> {
  __$$BranchImplCopyWithImpl(
      _$BranchImpl _value, $Res Function(_$BranchImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? structId = freezed,
    Object? structName = freezed,
    Object? structNameAr = freezed,
    Object? selected = freezed,
  }) {
    return _then(_$BranchImpl(
      structId: freezed == structId
          ? _value.structId
          : structId // ignore: cast_nullable_to_non_nullable
              as int?,
      structName: freezed == structName
          ? _value.structName
          : structName // ignore: cast_nullable_to_non_nullable
              as String?,
      structNameAr: freezed == structNameAr
          ? _value.structNameAr
          : structNameAr // ignore: cast_nullable_to_non_nullable
              as String?,
      selected: freezed == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BranchImpl implements _Branch {
  _$BranchImpl(
      {@JsonKey(name: 'struct_id') this.structId,
      @JsonKey(name: 'struct_name') this.structName,
      @JsonKey(name: 'struct_name_ar') this.structNameAr,
      this.selected});

  factory _$BranchImpl.fromJson(Map<String, dynamic> json) =>
      _$$BranchImplFromJson(json);

  @override
  @JsonKey(name: 'struct_id')
  final int? structId;
  @override
  @JsonKey(name: 'struct_name')
  final String? structName;
  @override
  @JsonKey(name: 'struct_name_ar')
  final String? structNameAr;
  @override
  final bool? selected;

  @override
  String toString() {
    return 'Branch(structId: $structId, structName: $structName, structNameAr: $structNameAr, selected: $selected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BranchImpl &&
            (identical(other.structId, structId) ||
                other.structId == structId) &&
            (identical(other.structName, structName) ||
                other.structName == structName) &&
            (identical(other.structNameAr, structNameAr) ||
                other.structNameAr == structNameAr) &&
            (identical(other.selected, selected) ||
                other.selected == selected));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, structId, structName, structNameAr, selected);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BranchImplCopyWith<_$BranchImpl> get copyWith =>
      __$$BranchImplCopyWithImpl<_$BranchImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BranchImplToJson(
      this,
    );
  }
}

abstract class _Branch implements Branch {
  factory _Branch(
      {@JsonKey(name: 'struct_id') final int? structId,
      @JsonKey(name: 'struct_name') final String? structName,
      @JsonKey(name: 'struct_name_ar') final String? structNameAr,
      final bool? selected}) = _$BranchImpl;

  factory _Branch.fromJson(Map<String, dynamic> json) = _$BranchImpl.fromJson;

  @override
  @JsonKey(name: 'struct_id')
  int? get structId;
  @override
  @JsonKey(name: 'struct_name')
  String? get structName;
  @override
  @JsonKey(name: 'struct_name_ar')
  String? get structNameAr;
  @override
  bool? get selected;
  @override
  @JsonKey(ignore: true)
  _$$BranchImplCopyWith<_$BranchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
