import 'package:flutter/material.dart';

import '../screens/add_category.dart';
import '../variable/colors/color_pallete.dart';
import '../variable/sizes/sizes.dart';

class EmptyCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: colorPallete.black.withOpacity(.6),
        fontWeight: FontWeight.bold,
      ),
      child: InkWell(
        onTap: () => showBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
            ),
          ),
          builder: (smbContext) {
            return AddCategory();
          },
        ),
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
                    'Kamu Belum Ada Kategori. Tekan Untuk Tambah Kategori',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 10,
                      color: colorPallete.defaultTextDynamicColor(context),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
