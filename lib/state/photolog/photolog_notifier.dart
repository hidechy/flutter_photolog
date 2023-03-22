// ignore_for_file: avoid_catches_without_on_clauses, empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'photolog_state.dart';

final photologProvider = StateNotifierProvider.autoDispose<
    PhotologStateNotifier, List<PhotologState>>((ref) {
  return PhotologStateNotifier([])..getAll();
});

class PhotologStateNotifier extends StateNotifier<List<PhotologState>> {
  PhotologStateNotifier(super.state);

  ///
  Future<void> getAll() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('photolog')
        .orderBy('index', descending: true)
        .get();

    final list = snapshot.docs.map((DocumentSnapshot document) {
      final data = document.data()! as Map<String, dynamic>;

      return PhotologState(
        id: document.id,
        date: data['date'].toString(),
        time: data['time'].toString(),
        lat: data['lat'].toString(),
        lng: data['lng'].toString(),
        image: data['image'].toString(),
        index: data['index'].toString(),
      );
    }).toList();

    state = list;
  }

  ///
  Future<void> delete({required PhotologState param}) async {
    try {
      ///
      final storageReference = FirebaseStorage.instance.refFromURL(param.image);
      await storageReference.delete();

      ///
      return FirebaseFirestore.instance
          .collection('photolog')
          .doc(param.id)
          .delete();
    } catch (error) {}
  }
}
