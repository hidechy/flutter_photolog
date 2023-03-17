// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../state/lat_lng/lat_lng_notifier.dart';
import '../state/lat_lng/lat_lng_request_state.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  String funabashi = '35.7102009,139.9490672';
  String zenpukuji = '35.7185071,139.5869534';

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final latLngState = ref.watch(latLngProvider);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          IconButton(
            onPressed: () {
              getLocation();
            },
            icon: const Icon(Icons.location_on),
          ),
          Divider(
            color: Colors.white.withOpacity(0.5),
            thickness: 2,
          ),
          Text(latLngState.lat.toString()),
          Text(latLngState.lng.toString()),
        ],
      ),
    );
  }

  ///
  Future<void> getLocation() async {
    // --- 追記 ---
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    // -- 追記おわり --

    // 現在の位置を返す
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // 北緯がプラス。南緯がマイナス
    debugPrint('緯度: ${position.latitude}');

    // 東経がプラス、西経がマイナス
    debugPrint('経度: ${position.longitude}');

    var param = LatLngRequestState(
      lat: position.latitude,
      lng: position.longitude,
    );

    _ref.watch(latLngProvider.notifier).setLatLng(param: param);

    //

    // 高度
    debugPrint('高度: ${position.altitude}');

    //

    var exFunabashi = funabashi.split(',');
    var exZenpukuji = zenpukuji.split(',');

    // 距離をメートルで返す
    final distanceInMeters = Geolocator.distanceBetween(
      exFunabashi[0].toString().toDouble(),
      exFunabashi[1].toString().toDouble(),
      exZenpukuji[0].toString().toDouble(),
      exZenpukuji[1].toString().toDouble(),
    );

    debugPrint('距離:$distanceInMeters');

    // 方位を返す
    final bearing = Geolocator.bearingBetween(
      exFunabashi[0].toString().toDouble(),
      exFunabashi[1].toString().toDouble(),
      exZenpukuji[0].toString().toDouble(),
      exZenpukuji[1].toString().toDouble(),
    );

    debugPrint('方位:$bearing');
  }
}