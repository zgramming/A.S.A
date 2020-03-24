import 'package:flutter/material.dart';
import '../variable/colors/color_pallete.dart';
import '../variable/sizes/sizes.dart';

class CardSettings extends StatelessWidget {
  final Function onTap;
  final String titleCard;
  final IconData iconCard;
  CardSettings({
    @required this.onTap,
    @required this.titleCard,
    @required this.iconCard,
  });
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        height: sizes.height(context) / 5,
        width: sizes.width(context),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(60), top: Radius.circular(10))),
          color: colorPallete.cardDynamicColor(context),
          child: InkWell(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(60), top: Radius.circular(10)),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: FittedBox(
                      child: Text(
                        titleCard,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 10,
                    fit: FlexFit.tight,
                    child: Icon(
                      iconCard,
                      size: sizes.width(context) / 7,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
