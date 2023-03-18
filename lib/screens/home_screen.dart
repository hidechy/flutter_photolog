// ignore_for_file: must_be_immutable, avoid_catches_without_on_clauses, empty_catches

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../extensions/extensions.dart';
import '../state/lat_lng/lat_lng_notifier.dart';
import '../state/lat_lng/lat_lng_request_state.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: getLocation,
                    icon: const Icon(Icons.location_on),
                  ),
                  IconButton(
                    onPressed: photoget,
                    icon: const Icon(Icons.camera),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(latLngState.lat.toString()),
                  Text(latLngState.lng.toString()),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  Future<void> getLocation() async {
    // --- 追記 ---
    var permission = await Geolocator.checkPermission();
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

    final param = LatLngRequestState(
      lat: position.latitude,
      lng: position.longitude,
    );

    await _ref.watch(latLngProvider.notifier).setLatLng(param: param);

    //

    // 高度
    debugPrint('高度: ${position.altitude}');

    //

    final exFunabashi = funabashi.split(',');
    final exZenpukuji = zenpukuji.split(',');

    // 距離をメートルで返す
    final distanceInMeters = Geolocator.distanceBetween(
      exFunabashi[0].toDouble(),
      exFunabashi[1].toDouble(),
      exZenpukuji[0].toDouble(),
      exZenpukuji[1].toDouble(),
    );

    debugPrint('距離:$distanceInMeters');

    // 方位を返す
    final bearing = Geolocator.bearingBetween(
      exFunabashi[0].toDouble(),
      exFunabashi[1].toDouble(),
      exZenpukuji[0].toDouble(),
      exZenpukuji[1].toDouble(),
    );

    debugPrint('方位:$bearing');
  }

  ///
  Future<void> photoget() async {
    final imagePicker = ImagePicker();

    final file = await imagePicker.pickImage(source: ImageSource.camera);

    print('${file?.path}');

    if (file == null) {
      return;
    }

    final uniqueFileName = DateTime.now().toString();

    final referenceRoot = FirebaseStorage.instance.ref();
    final referenceDirImages = referenceRoot.child(DateTime.now().yyyymmdd);
    final referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(File(file.path));

      final aaa = await referenceImageToUpload.getDownloadURL();

      print(aaa);
    } catch (error) {}
  }
}
