// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pos_main.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PosMain _$PosMainFromJson(Map<String, dynamic> json) {
  return _PosMain.fromJson(json);
}

/// @nodoc
mixin _$PosMain {
  bool? get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Data? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PosMainCopyWith<PosMain> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PosMainCopyWith<$Res> {
  factory $PosMainCopyWith(PosMain value, $Res Function(PosMain) then) =
      _$PosMainCopyWithImpl<$Res, PosMain>;
  @useResult
  $Res call({bool? success, String? message, Data? data});

  $DataCopyWith<$Res>? get data;
}

/// @nodoc
class _$PosMainCopyWithImpl<$Res, $Val extends PosMain>
    implements $PosMainCopyWith<$Res> {
  _$PosMainCopyWithImpl(this._value, this._then);

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
abstract class _$$PosMainImplCopyWith<$Res> implements $PosMainCopyWith<$Res> {
  factory _$$PosMainImplCopyWith(
          _$PosMainImpl value, $Res Function(_$PosMainImpl) then) =
      __$$PosMainImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? success, String? message, Data? data});

  @override
  $DataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$PosMainImplCopyWithImpl<$Res>
    extends _$PosMainCopyWithImpl<$Res, _$PosMainImpl>
    implements _$$PosMainImplCopyWith<$Res> {
  __$$PosMainImplCopyWithImpl(
      _$PosMainImpl _value, $Res Function(_$PosMainImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$PosMainImpl(
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
class _$PosMainImpl implements _PosMain {
  _$PosMainImpl({this.success, this.message, this.data});

  factory _$PosMainImpl.fromJson(Map<String, dynamic> json) =>
      _$$PosMainImplFromJson(json);

  @override
  final bool? success;
  @override
  final String? message;
  @override
  final Data? data;

  @override
  String toString() {
    return 'PosMain(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PosMainImpl &&
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
  _$$PosMainImplCopyWith<_$PosMainImpl> get copyWith =>
      __$$PosMainImplCopyWithImpl<_$PosMainImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PosMainImplToJson(
      this,
    );
  }
}

abstract class _PosMain implements PosMain {
  factory _PosMain(
      {final bool? success,
      final String? message,
      final Data? data}) = _$PosMainImpl;

  factory _PosMain.fromJson(Map<String, dynamic> json) = _$PosMainImpl.fromJson;

  @override
  bool? get success;
  @override
  String? get message;
  @override
  Data? get data;
  @override
  @JsonKey(ignore: true)
  _$$PosMainImplCopyWith<_$PosMainImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
