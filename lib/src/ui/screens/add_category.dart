import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import '../variable/colors/color_pallete.dart';
import '../variable/config/app_config.dart';
import '../variable/sizes/sizes.dart';

import '../widgets/button_custom.dart';
import '../widgets/textformfield_custom.dart';

import '../../providers/category_provider.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final _formKey = GlobalKey<FormState>();
  String titleForm;
  String informationForm;

  void _validate({CategoryProvider ctgProvider}) async {
    final dateNow = DateTime.now();
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      ctgProvider.addingCategory(
        idCategory: dateNow.toIso8601String(),
        titleCategory: titleForm,
        codeIconCategory: ctgProvider.iconCodeFromIconPicker,
        informationCategory: informationForm,
        createDate: dateNow.toIso8601String(),
      );
      Navigator.of(context).pop(true);
    } else {
      return null;
    }
  }

  void _pickIcon(CategoryProvider ctgProvider) async {
    final openIconPicker = await FlutterIconPicker.showIconPicker(
      context,
      iconSize: 40,
      noResultsText: appConfig.noResultIconText,
    );
    if (openIconPicker == null) {
      return null;
    }
    print(openIconPicker.codePoint);
    ctgProvider.setCodeIconFromIconPicker(openIconPicker.codePoint);
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 8.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(true),
              ),
              SizedBox(height: 15),
              InkWell(
                onTap: () => _pickIcon(categoryProvider),
                child: CircleAvatar(
                  radius: sizes.width(context) / 8,
                  backgroundColor:
                      colorPallete.circleAvatarPickerIconDynamicColor(context),
                  child: (categoryProvider.iconCodeFromIconPicker == 0)
                      ? Text(appConfig.pickIcon,
                          style: TextStyle(color: colorPallete.white))
                      : Icon(
                          IconData(
                            categoryProvider.iconCodeFromIconPicker,
                            fontFamily: appConfig.fontFamilyIcon,
                          ),
                          size: sizes.width(context) / 6,
                          color: Colors.white,
                        ),
                ),
              ),
              SizedBox(height: 15),
              Divider(),
              SizedBox(height: 15),
              TextFormFieldCustom(
                onSaved: (value) => titleForm = value,
                labelText: appConfig.titleCategoryText,
                hintText: appConfig.titleCategoryText,
                prefixIcon: Icons.title,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) => _validate(
                  ctgProvider: categoryProvider,
                ),
              ),
              SizedBox(height: 15),
              TextFormFieldCustom(
                onSaved: (value) => informationForm = value,
                labelText: appConfig.informationCategoryText,
                hintText: appConfig.informationCategoryText,
                prefixIcon: Icons.info,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                isValidatorEnable: false,
              ),
              SizedBox(height: 15),
              ButtonCustom(
                onPressed: (categoryProvider.iconCodeFromIconPicker == 0)
                    ? null
                    : () => _validate(
                          ctgProvider: categoryProvider,
                        ),
                buttonColor: Theme.of(context).accentColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
