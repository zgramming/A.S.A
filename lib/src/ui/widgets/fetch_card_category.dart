import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/category_provider.dart';
import '../variable/colors/color_pallete.dart';
import '../variable/sizes/sizes.dart';
import '../widgets/empty_category.dart';

class FetchCardCategory extends StatefulWidget {
  @override
  _FetchCardCategoryState createState() => _FetchCardCategoryState();
}

class _FetchCardCategoryState extends State<FetchCardCategory> {
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return SizedBox(
      height: sizes.height(context) / 7,
      child: categoryProvider.allCategoryItem.length == 0
          ? EmptyCategory()
          : ListView.builder(
              itemCount: categoryProvider.allCategoryItem.length,
              shrinkWrap: true,
              itemExtent: sizes.width(context) / 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final result = categoryProvider.allCategoryItem[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    side: categoryProvider.selectedIndexCardCategory == index
                        ? BorderSide(color: Colors.green, width: 2)
                        : BorderSide(color: colorPallete.grey),
                  ),
                  child: InkWell(
                    onTap: () {
                      categoryProvider.setSelectedIndexAndIconCodeCardCategory(
                        index,
                        result.codeIconCategory,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Flexible(
                            child: FittedBox(
                              child: Text(
                                result.titleCategory,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            fit: FlexFit.tight,
                            flex: 5,
                          ),
                          Flexible(
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  IconData(
                                    result.codeIconCategory,
                                    fontFamily: "MaterialIcons",
                                  ),
                                ),
                              ),
                            ),
                            fit: FlexFit.tight,
                            flex: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
