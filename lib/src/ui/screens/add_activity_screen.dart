import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/category_provider.dart';
import '../../providers/main_calendar_provider.dart';
import '../../function/show_snackbar_message.dart';
import '../variable/colors/color_pallete.dart';
import '../variable/config/app_config.dart';
import '../variable/sizes/sizes.dart';
import '../widgets/button_custom.dart';
import '../widgets/fetch_card_category.dart';
import '../widgets/textformfield_custom.dart';
import '../screens/add_category.dart';

class AddActivityScreen extends StatefulWidget {
  static String routeName = '/add-activity-screen';

  @override
  _AddActivityScreenState createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final _formKey = GlobalKey<FormState>();

  String titleForm;
  String informationForm;

  @override
  void initState() {
    super.initState();
    titleForm = '';
    informationForm = '';
  }

  void _validate({
    @required MainCalendarProvider mcProvider,
    @required CategoryProvider ctgProvider,
    @required BuildContext ctx,
  }) async {
    final form = _formKey.currentState;
    final dateNow = DateTime.now();
    if (mcProvider.selectedDateFromCupertinoDatePicker.isBefore(dateNow)) {
      showSnackbarMessage.showSnackBarMessage(
        context: ctx,
        message: appConfig.snackbarErrorDateText,
      );
      return null;
    } else {
      if (form.validate()) {
        form.save();
        await mcProvider.addingActivity(
          idActivity: dateNow.toString(),
          titleActivity: titleForm,
          dateTimeActivity:
              mcProvider.selectedDateFromCupertinoDatePicker.toString(),
          isDoneActivity: 0,
          codeIconActivity: ctgProvider.selectedIconCodeCardCategory,
          informationActivity: informationForm,
          createdDateActivity: dateNow.toString(),
        );
        ctgProvider.resetSelectedIndexAndIconCodeCardCategory();
        mcProvider.resetSelectedDateFromCupertinoDatePicker();

        Navigator.of(context).pop(true);
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map result = ModalRoute.of(context).settings.arguments as Map;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tambah Aktifitas'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: sizes.height(context) / 20,
                  bottom: sizes.height(context) / 20,
                ),
                child: Card(
                  elevation: 3,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(60),
                      topLeft: Radius.circular(15),
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 10.0,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          formatColumn(
                            widget: TextFormFieldCustom(
                              onSaved: (value) => titleForm = value,
                              labelText: 'Judul Aktifitas',
                              hintText: 'Tambahkan Judul Dalam Aktifitasmu',
                              prefixIcon: Icon(Icons.title),
                              radius: 50,
                              isDone: true,
                            ),
                            title: 'Judul ',
                          ),
                          formatColumn(
                              widget: Consumer<MainCalendarProvider>(
                                builder: (_, mcProvider, __) => SizedBox(
                                  height: sizes.height(context) / 3.5,
                                  child: CupertinoTheme(
                                    data: CupertinoThemeData(
                                      textTheme: CupertinoTextThemeData(
                                        dateTimePickerTextStyle: TextStyle(
                                          color: colorPallete
                                              .cupertinoDateTimeTextDynamicColor(
                                            context,
                                          ),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    child: CupertinoDatePicker(
                                      initialDateTime: result['dateRevision'],
                                      minimumDate: result['dateRevision'],
                                      use24hFormat: true,
                                      onDateTimeChanged: (dateChange) {
                                        mcProvider
                                            .setSelectedDateFromCupertinoDatePicker(
                                          dateChange,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              title: 'Tanggal'),
                          Builder(
                            builder: (currentContext) => formatColumn(
                              widget: FetchCardCategory(),
                              title: 'Kategori',
                              enableIconAdd: true,
                              onTap: () => showBottomSheet(
                                context: currentContext,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(40),
                                  ),
                                ),
                                builder: (smbContext) => AddCategory(),
                              ),
                            ),
                          ),
                          formatColumn(
                            widget: TextFormFieldCustom(
                              onSaved: (value) => informationForm = value,
                              hintText: 'Tambah Keterangan Pada Aktifitasmu',
                              labelText: 'Keterangan',
                              prefixIcon: Icon(Icons.info),
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              minLines: 3,
                              maxLines: 5,
                              isValidatorEnable: false,
                            ),
                            title: 'Keterangan',
                          ),
                          Builder(
                            builder: (acsContext) => Consumer2<
                                MainCalendarProvider, CategoryProvider>(
                              builder: (_, mcProvider, ctgProvider, __) =>
                                  ButtonCustom(
                                onPressed: (mcProvider
                                            .selectedDateFromCupertinoDatePicker ==
                                        null)
                                    ? null
                                    : () => _validate(
                                          mcProvider: mcProvider,
                                          ctgProvider: ctgProvider,
                                          ctx: acsContext,
                                        ),
                                buttonColor: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column formatColumn({
    @required Widget widget,
    @required String title,
    Function onTap,
    bool enableIconAdd = false,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              enableIconAdd
                  ? IconButton(
                      icon: Icon(Icons.add),
                      onPressed: onTap,
                      tooltip: 'Tambah Kategori',
                    )
                  : SizedBox(),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          SizedBox(height: 10),
          widget,
          Divider(),
          SizedBox(height: 10),
        ],
      );
}
