// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/lat_lng/lat_lng_notifier.dart';
import '../../state/photolog/photolog_notifier.dart';
import '../../state/photolog/photolog_state.dart';
import '../_alert/photo_display_alert.dart';
import '../home_screen.dart';
import 'photolog_dialog.dart';

class PhotologCard extends ConsumerWidget {
  const PhotologCard({super.key, required this.data});

  final PhotologState data;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
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
          GestureDetector(
            onTap: () {
              PhotologDialog(
                context: context,
                widget: PhotoDisplayAlert(data: data),
              );
            },
            child: SizedBox(
              width: 50,
              child: Image.network(data.image),
            ),
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
                      data.id,
                      style: TextStyle(
                        color: Colors.grey.withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
                Text(data.time),
                Divider(color: Colors.white.withOpacity(0.2), thickness: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [Text(data.lat), Text(data.lng)],
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () async {
                            await ref
                                .watch(photologProvider.notifier)
                                .delete(param: data);

                            await ref.watch(latLngProvider.notifier).refresh();

                            await ref.watch(photologProvider.notifier).getAll();

                            await Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.white.withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
