// ignore_for_file: must_be_immutable, avoid_catches_without_on_clauses, empty_catches, cascade_invocations

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../extensions/extensions.dart';
import '../state/lat_lng/lat_lng_notifier.dart';
import '../state/lat_lng/lat_lng_request_state.dart';
import '../state/photolog/photolog_notifier.dart';
import '../utility/utility.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  String funabashi = '35.7102009,139.9490672';
  String zenpukuji = '35.7185071,139.5869534';

  String imageUrl = '';

  final Utility _utility = Utility();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final latLngState = ref.watch(latLngProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(),
          Column(
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
                      const SizedBox(width: 20),
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
              Text(latLngState.imageUrl),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () async {
                      await dataSaving();

                      await _ref.watch(latLngProvider.notifier).refresh();

                      await _ref.watch(photologProvider.notifier).getAll();
                    },
                    icon: const Icon(Icons.input),
                  ),
                  IconButton(
                    onPressed: () async {
                      await _ref.watch(latLngProvider.notifier).refresh();

                      await _ref.watch(photologProvider.notifier).getAll();
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.yellowAccent,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.white.withOpacity(0.6),
                thickness: 2,
              ),
              Expanded(
                child: photolist(),
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

    if (file == null) {
      return;
    }

    final uniqueFileName = DateTime.now().toString();

    final referenceRoot = FirebaseStorage.instance.ref();
    final referenceDirImages = referenceRoot.child(DateTime.now().yyyymmdd);
    final referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(File(file.path));

      imageUrl = await referenceImageToUpload.getDownloadURL();

      await _ref.watch(latLngProvider.notifier).setImageUrl(imageUrl: imageUrl);
    } catch (error) {}
  }

  ///
  Future<void> dataSaving() async {
    final latLngState = _ref.watch(latLngProvider);
    if (latLngState.lat == 0.0 || latLngState.lng == 0.0) {
      ScaffoldMessenger.of(_context).showSnackBar(
        const SnackBar(content: Text('no lat lng')),
      );

      return;
    }

    if (imageUrl.isEmpty) {
      ScaffoldMessenger.of(_context).showSnackBar(
        const SnackBar(content: Text('no image')),
      );

      return;
    }

    final timeFormat = DateFormat('HH:mm:ss');

    final param = <String, String>{
      'date': DateTime.now().yyyymmdd,
      'time': timeFormat.format(DateTime.now()),
      'lat': latLngState.lat.toString(),
      'lng': latLngState.lng.toString(),
      'image': imageUrl,
      'index':
          '${DateTime.now().yyyymmdd}_${timeFormat.format(DateTime.now())}',
    };

    final CollectionReference reference =
        FirebaseFirestore.instance.collection('photolog');

    await reference.add(param);
  }

  ///
  Widget photolist() {
    final list = <Widget>[];

    final photologState = _ref.watch(photologProvider);

    var keepDate = '';
    photologState.forEach((element) {
      if (element.date != keepDate) {
        list.add(
          Container(
            width: _context.screenSize.width,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.yellowAccent.withOpacity(0.2),
            ),
            child: Text(element.date),
          ),
        );
      }

      list.add(
        Slidable(
          endActionPane: ActionPane(
            extentRatio: 0.2,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) async {
                  await _ref
                      .watch(photologProvider.notifier)
                      .delete(param: element);

                  await _ref.watch(latLngProvider.notifier).refresh();

                  await _ref.watch(photologProvider.notifier).getAll();
                },
                backgroundColor: const Color(0xFF0392CF),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'delete',
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 50,
                  child: Image.network(element.image),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Text(
                            element.id,
                            style: TextStyle(
                              color: Colors.grey.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                      Text(element.time),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(element.lat),
                                  Text(element.lng)
                                ],
                              ),
                              const SizedBox(width: 10),
                              const Icon(Icons.location_on),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      keepDate = element.date;
    });

    return SingleChildScrollView(
      child: Column(children: list),
    );
  }
}
