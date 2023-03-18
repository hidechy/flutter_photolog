import 'package:freezed_annotation/freezed_annotation.dart';

part 'photolog_state.freezed.dart';

@freezed
class PhotologState with _$PhotologState {
  const factory PhotologState({
    required String id,
    required String date,
    required String time,
    required String lat,
    required String lng,
    required String image,
    required String index,
  }) = _PhotologState;
}
