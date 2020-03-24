import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import '../../providers/category_provider.dart';

import '../variable/colors/color_pallete.dart';
import '../variable/config/app_config.dart';
import '../variable/sizes/sizes.dart';
import '../widgets/button_custom.dart';
import '../widgets/textformfield_custom.dart';

class EditCategory extends StatefulWidget {
  @override
  _EditCategoryState createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  final _formKey = GlobalKey<FormState>();
  String titleForm;
  String informationForm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 8.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(true),
            ),
            SizedBox(height: 15),
            Consumer<CategoryProvider>(
              builder: (_, ctgProvider, __) => ListView.separated(
                separatorBuilder: (ctxSeparated, index) => Divider(
                  color: colorPallete.dividerDynamicColor(ctxSeparated),
                ),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: ctgProvider.allCategoryItem.length,
                itemBuilder: (BuildContext context, int index) {
                  final result = ctgProvider.allCategoryItem[index];
                  return Column(
                    children: <Widget>[
                      Card(
                        child: listTileEditCategory(
                          title: result.titleCategory,
                          subtitle: result.informationCategory,
                          context: context,
                          codeIcon: result.codeIconCategory,
                          onTapIcon: () =>
                              _pickIcon(ctgProvider, result.idCategory),
                          onTapEdit: () => ctgProvider.setShowEditCategory(
                            ctgProvider.showEditCategory,
                            index,
                          ),
                          onTapDelete: () => ctgProvider.deleteCategory(
                            idCategory: result.idCategory,
                          ),
                        ),
                      ),
                      Visibility(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormFieldCustom(
                                  onSaved: (value) => titleForm = value,
                                  labelText: appConfig.titleCategoryText,
                                  hintText: appConfig.titleCategoryText,
                                  prefixIcon: Icon(Icons.title),
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (value) => _validate(
                                    ctgProvider: ctgProvider,
                                    idCategory: result.idCategory,
                                  ),
                                  initialValue: result.titleCategory,
                                ),
                                SizedBox(height: 10),
                                TextFormFieldCustom(
                                  onSaved: (value) => informationForm = value,
                                  labelText: appConfig.informationCategoryText,
                                  hintText: appConfig.informationCategoryText,
                                  prefixIcon: Icon(Icons.info),
                                  textInputAction: TextInputAction.newline,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 3,
                                  isValidatorEnable: false,
                                  initialValue: result.informationCategory,
                                ),
                                SizedBox(height: 10),
                                ButtonCustom(
                                  onPressed: () => _validate(
                                    ctgProvider: ctgProvider,
                                    idCategory: result.idCategory,
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                        visible: (ctgProvider.showEditCategory &&
                                ctgProvider.indexEditCategory == index)
                            ? true
                            : false,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pickIcon(CategoryProvider ctgProvider, String idCategory) async {
    final openIconPicker = await FlutterIconPicker.showIconPicker(
      context,
      iconSize: 40,
      noResultsText: appConfig.noResultIconText,
    );
    if (openIconPicker == null) {
      return null;
    }
    print(openIconPicker.codePoint);
    ctgProvider.setCodeIconFromIconPicker(
      openIconPicker.codePoint,
    );
    ctgProvider.updateIconCategory(
      ctgProvider.iconCodeFromIconPicker,
      idCategory,
    );
  }

  void _validate({
    @required CategoryProvider ctgProvider,
    @required String idCategory,
  }) async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      await ctgProvider.updateCategory(
        titleCategory: titleForm,
        informationCategory: informationForm,
        idCategory: idCategory,
      );
      // Navigator.of(context).pop(true);
    } else {
      return null;
    }
  }

  Padding listTileEditCategory({
    @required String title,
    @required String subtitle,
    @required BuildContext context,
    @required int codeIcon,
    Function onTapIcon,
    Function onTapEdit,
    Function onTapDelete,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Theme.of(context).primaryColor,
            ),
            child: IconButton(
              icon: Icon(
                IconData(codeIcon, fontFamily: appConfig.fontFamilyIcon),
                size: sizes.width(context) / 10,
                color: colorPallete.white,
              ),
              onPressed: onTapIcon,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(fontSize: 12.0),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Row(
            children: <Widget>[
              InkWell(
                onTap: onTapEdit,
                child: CircleAvatar(
                  backgroundColor: colorPallete.cardDynamicColor(context),
                  child: Icon(
                    Icons.mode_edit,
                    color: colorPallete.circleAvatarIconDynamicColor(
                        context: context),
                  ),
                ),
              ),
              SizedBox(width: 5),
              InkWell(
                onTap: onTapDelete,
                child: CircleAvatar(
                  backgroundColor: colorPallete.cardDynamicColor(context),
                  child: Icon(
                    Icons.delete,
                    color: colorPallete.circleAvatarIconDynamicColor(
                      context: context,
                      isDeleteIcon: true,
                    ),
                  ),
                ),
              ),
            ],
            mainAxisSize: MainAxisSize.min,
          ),
        ),
      );
}
