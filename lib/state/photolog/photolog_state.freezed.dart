// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photolog_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PhotologState {
  String get id => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  String get lat => throw _privateConstructorUsedError;
  String get lng => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  String get index => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PhotologStateCopyWith<PhotologState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotologStateCopyWith<$Res> {
  factory $PhotologStateCopyWith(
          PhotologState value, $Res Function(PhotologState) then) =
      _$PhotologStateCopyWithImpl<$Res, PhotologState>;
  @useResult
  $Res call(
      {String id,
      String date,
      String time,
      String lat,
      String lng,
      String image,
      String index});
}

/// @nodoc
class _$PhotologStateCopyWithImpl<$Res, $Val extends PhotologState>
    implements $PhotologStateCopyWith<$Res> {
  _$PhotologStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? time = null,
    Object? lat = null,
    Object? lng = null,
    Object? image = null,
    Object? index = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as String,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PhotologStateCopyWith<$Res>
    implements $PhotologStateCopyWith<$Res> {
  factory _$$_PhotologStateCopyWith(
          _$_PhotologState value, $Res Function(_$_PhotologState) then) =
      __$$_PhotologStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String date,
      String time,
      String lat,
      String lng,
      String image,
      String index});
}

/// @nodoc
class __$$_PhotologStateCopyWithImpl<$Res>
    extends _$PhotologStateCopyWithImpl<$Res, _$_PhotologState>
    implements _$$_PhotologStateCopyWith<$Res> {
  __$$_PhotologStateCopyWithImpl(
      _$_PhotologState _value, $Res Function(_$_PhotologState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? time = null,
    Object? lat = null,
    Object? lng = null,
    Object? image = null,
    Object? index = null,
  }) {
    return _then(_$_PhotologState(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as String,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_PhotologState implements _PhotologState {
  const _$_PhotologState(
      {required this.id,
      required this.date,
      required this.time,
      required this.lat,
      required this.lng,
      required this.image,
      required this.index});

  @override
  final String id;
  @override
  final String date;
  @override
  final String time;
  @override
  final String lat;
  @override
  final String lng;
  @override
  final String image;
  @override
  final String index;

  @override
  String toString() {
    return 'PhotologState(id: $id, date: $date, time: $time, lat: $lat, lng: $lng, image: $image, index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PhotologState &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, date, time, lat, lng, image, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PhotologStateCopyWith<_$_PhotologState> get copyWith =>
      __$$_PhotologStateCopyWithImpl<_$_PhotologState>(this, _$identity);
}

abstract class _PhotologState implements PhotologState {
  const factory _PhotologState(
      {required final String id,
      required final String date,
      required final String time,
      required final String lat,
      required final String lng,
      required final String image,
      required final String index}) = _$_PhotologState;

  @override
  String get id;
  @override
  String get date;
  @override
  String get time;
  @override
  String get lat;
  @override
  String get lng;
  @override
  String get image;
  @override
  String get index;
  @override
  @JsonKey(ignore: true)
  _$$_PhotologStateCopyWith<_$_PhotologState> get copyWith =>
      throw _privateConstructorUsedError;
}
