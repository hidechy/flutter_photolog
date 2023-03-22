import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import '../../state/photolog/photolog_state.dart';

class PhotoDisplayAlert extends StatelessWidget {
  const PhotoDisplayAlert({super.key, required this.data});

  final PhotologState data;

  ///
  @override
  Widget build(BuildContext context) {
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
              Image.network(data.image),
            ],
          ),
        ),
      ),
    );
  }
}
