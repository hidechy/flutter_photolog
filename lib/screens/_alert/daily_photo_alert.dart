// ignore_for_file: must_be_immutable, cascade_invocations, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/photolog/photolog_notifier.dart';
import '../_parts/photolog_card.dart';

class DailyPhotoAlert extends ConsumerWidget {
  DailyPhotoAlert({super.key, required this.date});

  final DateTime date;

  List<String> bunruiList = [];

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    return AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height - 50,
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 12),
          child: Column(
            children: [
              Container(width: context.screenSize.width),
              Container(
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent.withOpacity(0.2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(date.yyyymmdd),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.location_on),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: photolist(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget photolist() {
    final list = <Widget>[];

    final photologState = _ref.watch(photologProvider);

    photologState.forEach((element) {
      if (date.yyyymmdd == element.date) {
        list.add(PhotologCard(data: element));
      }
    });

    return SingleChildScrollView(
      child: Column(children: list),
    );
  }
}
