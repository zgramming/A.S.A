import 'package:flutter/material.dart';

import '../variable/colors/color_pallete.dart';
import '../variable/sizes/sizes.dart';

class EmptyNearbyActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
          color: colorPallete.greyTransparent, fontWeight: FontWeight.bold),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Image.asset(
                'assets/images/empty-category.png',
                height: sizes.width(context) / 4,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Sepertinya Kamu Belum Ada Aktifitas, Ayo Tambahkan Sekarang...',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
