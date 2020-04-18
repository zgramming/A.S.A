import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_category.dart';

import '../widgets/button_custom.dart';
import '../widgets/fetch_card_category.dart';
import '../widgets/textformfield_custom.dart';

import '../variable/colors/color_pallete.dart';
import '../variable/config/app_config.dart';
import '../variable/sizes/sizes.dart';

import '../../providers/category_provider.dart';
import '../../providers/main_calendar_provider.dart';

import '../../network/models/activity/activity_model.dart';

import '../../function/show_snackbar_message.dart';
import '../../function/show_schedule_notification.dart';

import '../screens/welcome_screen.dart';

class AddActivityScreen extends StatefulWidget {
  static String routeName = '/add-activity-screen';

  @override
  _AddActivityScreenState createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final _formKey = GlobalKey<FormState>();

  String titleForm;
  String informationForm;
  String appBarTitle;
  int codeIconActivity;
  ActivityModel editArgs;
  DateTime dateTimeActivityArgs;

  ShowNotificationSchedule notificationSchedule = ShowNotificationSchedule();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkArgs();
  }

  void checkArgs() async {
    final args = ModalRoute.of(context).settings.arguments;
    if (args == null) {
      // print('Args Is Null');
      appBarTitle = 'Tambah Aktifitas';
      titleForm = '';
      informationForm = '';
      return null;
    } else {
      // print('Args is available');
      appBarTitle = 'Edit Aktifitas';
      editArgs = args;
      titleForm = editArgs.titleActivity;
      informationForm = editArgs.informationActivity;
      dateTimeActivityArgs = DateTime.parse(editArgs.dateTimeActivity);
      codeIconActivity = editArgs.codeIconActivity;
    }
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
        if (editArgs == null) {
          /// Ini Buat Tambah Activity

          final resultLastId = await mcProvider.addingActivity(
            titleActivity: titleForm,
            dateTimeActivity:
                mcProvider.selectedDateFromCupertinoDatePicker.toString(),
            isDoneActivity: 0,
            codeIconActivity: ctgProvider.selectedIconCodeCardCategory,
            informationActivity: informationForm,
            createdDateActivity: dateNow.toString(),
          );
          await showNotificationSchedule.showNotificationSchedule(
            dateTimeShowNotification:
                mcProvider.selectedDateFromCupertinoDatePicker,
            idNotification: resultLastId,
            titleNotification: titleForm,
            bodyNotification: "Informasi Aktifitas : $informationForm",
            payloadNotification: "Saat Notifikasi Diklik",
          );
        } else {
          /// Ini Buat Edit Activity
          await mcProvider
              .updateActivity(
                titleActivity: titleForm,
                dateTimeActivity:
                    mcProvider.selectedDateFromCupertinoDatePicker.toString(),
                informationActivity: informationForm,
                codeIconActivity:
                    ctgProvider.selectedIconCodeCardCategory == 59566
                        ? codeIconActivity
                        : ctgProvider.selectedIconCodeCardCategory,
                idActivity: editArgs.idActivity,
              )
              .then((_) => showNotificationSchedule
                  .cancelNotificationById(editArgs.idActivity))
              .then((_) => showNotificationSchedule.showNotificationSchedule(
                    dateTimeShowNotification:
                        mcProvider.selectedDateFromCupertinoDatePicker,
                    idNotification: editArgs.idActivity,
                    titleNotification: titleForm,
                    bodyNotification: informationForm,
                    payloadNotification: "Saat Notifikasi Diklik Update",
                  ));
        }
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
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
                              prefixIcon: Icons.title,
                              radius: 50,
                              isDone: true,
                              initialValue: titleForm,
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
                                    child: Consumer<MainCalendarProvider>(
                                      builder: (_, mcProvider, __) =>
                                          CupertinoDatePicker(
                                        initialDateTime: editArgs == null
                                            ? mcProvider.initialDateCupertino
                                            : dateTimeActivityArgs,
                                        minimumDate:
                                            mcProvider.minDateCupertino,
                                        use24hFormat: true,
                                        onDateTimeChanged: (dateChange) {
                                          mcProvider
                                              .setSelectedDateFromCupertinoDatePicker(
                                            dateChange,
                                          );
                                          print(
                                              "DateTime From DatePicker : ${mcProvider.selectedDateFromCupertinoDatePicker}");
                                        },
                                      ),
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
                              prefixIcon: Icons.info,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              minLines: 3,
                              maxLines: 5,
                              isValidatorEnable: false,
                              initialValue: informationForm,
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
