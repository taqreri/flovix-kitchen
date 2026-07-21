// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'branches_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BranchesModel _$BranchesModelFromJson(Map<String, dynamic> json) {
  return _BranchesModel.fromJson(json);
}

/// @nodoc
mixin _$BranchesModel {
  bool? get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Data? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BranchesModelCopyWith<BranchesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BranchesModelCopyWith<$Res> {
  factory $BranchesModelCopyWith(
          BranchesModel value, $Res Function(BranchesModel) then) =
      _$BranchesModelCopyWithImpl<$Res, BranchesModel>;
  @useResult
  $Res call({bool? success, String? message, Data? data});

  $DataCopyWith<$Res>? get data;
}

/// @nodoc
class _$BranchesModelCopyWithImpl<$Res, $Val extends BranchesModel>
    implements $BranchesModelCopyWith<$Res> {
  _$BranchesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Data?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $DataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BranchesModelImplCopyWith<$Res>
    implements $BranchesModelCopyWith<$Res> {
  factory _$$BranchesModelImplCopyWith(
          _$BranchesModelImpl value, $Res Function(_$BranchesModelImpl) then) =
      __$$BranchesModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? success, String? message, Data? data});

  @override
  $DataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$BranchesModelImplCopyWithImpl<$Res>
    extends _$BranchesModelCopyWithImpl<$Res, _$BranchesModelImpl>
    implements _$$BranchesModelImplCopyWith<$Res> {
  __$$BranchesModelImplCopyWithImpl(
      _$BranchesModelImpl _value, $Res Function(_$BranchesModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$BranchesModelImpl(
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Data?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BranchesModelImpl implements _BranchesModel {
  _$BranchesModelImpl({this.success, this.message, this.data});

  factory _$BranchesModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BranchesModelImplFromJson(json);

  @override
  final bool? success;
  @override
  final String? message;
  @override
  final Data? data;

  @override
  String toString() {
    return 'BranchesModel(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BranchesModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BranchesModelImplCopyWith<_$BranchesModelImpl> get copyWith =>
      __$$BranchesModelImplCopyWithImpl<_$BranchesModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BranchesModelImplToJson(
      this,
    );
  }
}

abstract class _BranchesModel implements BranchesModel {
  factory _BranchesModel(
      {final bool? success,
      final String? message,
      final Data? data}) = _$BranchesModelImpl;

  factory _BranchesModel.fromJson(Map<String, dynamic> json) =
      _$BranchesModelImpl.fromJson;

  @override
  bool? get success;
  @override
  String? get message;
  @override
  Data? get data;
  @override
  @JsonKey(ignore: true)
  _$$BranchesModelImplCopyWith<_$BranchesModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
