// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lat_lng_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LatLngResponseState {
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LatLngResponseStateCopyWith<LatLngResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LatLngResponseStateCopyWith<$Res> {
  factory $LatLngResponseStateCopyWith(
          LatLngResponseState value, $Res Function(LatLngResponseState) then) =
      _$LatLngResponseStateCopyWithImpl<$Res, LatLngResponseState>;
  @useResult
  $Res call({double lat, double lng, String imageUrl});
}

/// @nodoc
class _$LatLngResponseStateCopyWithImpl<$Res, $Val extends LatLngResponseState>
    implements $LatLngResponseStateCopyWith<$Res> {
  _$LatLngResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lng = null,
    Object? imageUrl = null,
  }) {
    return _then(_value.copyWith(
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LatLngResponseStateCopyWith<$Res>
    implements $LatLngResponseStateCopyWith<$Res> {
  factory _$$_LatLngResponseStateCopyWith(_$_LatLngResponseState value,
          $Res Function(_$_LatLngResponseState) then) =
      __$$_LatLngResponseStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double lat, double lng, String imageUrl});
}

/// @nodoc
class __$$_LatLngResponseStateCopyWithImpl<$Res>
    extends _$LatLngResponseStateCopyWithImpl<$Res, _$_LatLngResponseState>
    implements _$$_LatLngResponseStateCopyWith<$Res> {
  __$$_LatLngResponseStateCopyWithImpl(_$_LatLngResponseState _value,
      $Res Function(_$_LatLngResponseState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lng = null,
    Object? imageUrl = null,
  }) {
    return _then(_$_LatLngResponseState(
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LatLngResponseState implements _LatLngResponseState {
  const _$_LatLngResponseState(
      {this.lat = 0.0, this.lng = 0.0, this.imageUrl = ''});

  @override
  @JsonKey()
  final double lat;
  @override
  @JsonKey()
  final double lng;
  @override
  @JsonKey()
  final String imageUrl;

  @override
  String toString() {
    return 'LatLngResponseState(lat: $lat, lng: $lng, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LatLngResponseState &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lat, lng, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LatLngResponseStateCopyWith<_$_LatLngResponseState> get copyWith =>
      __$$_LatLngResponseStateCopyWithImpl<_$_LatLngResponseState>(
          this, _$identity);
}

abstract class _LatLngResponseState implements LatLngResponseState {
  const factory _LatLngResponseState(
      {final double lat,
      final double lng,
      final String imageUrl}) = _$_LatLngResponseState;

  @override
  double get lat;
  @override
  double get lng;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_LatLngResponseStateCopyWith<_$_LatLngResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}
