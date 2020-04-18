import 'package:flutter/foundation.dart';
import '../../src/network/helper/sqflite_helper.dart';
import '../../src/network/models/activity/activity_model.dart';

class MainCalendarProvider extends ChangeNotifier {
  /// Melakukan Inisialisasi agar script dibawah ini  agar langsung berjalan

  MainCalendarProvider() {
    getUnFinishedActivity();
    getNearby10Activity();
    getActivityBasedOnDate();
    getAllActivity();
  }

  ///* initialize DB SQFLite
  DBHelper db = DBHelper();

  DateTime _dateSelectedActivityItem = DateTime.now();
  DateTime _selectedDateFromCupertinoDatePicker;
  DateTime _initialDateCupertino;
  DateTime _minDateCupertino;

  Map<DateTime, List<ActivityModel>> _activityBasedOnDate = {};

  List<ActivityModel> _nearby10ActivityItem = [];
  List<ActivityModel> _unFinishedActivityItem = [];
  List<ActivityModel> _selectedActivityItem = [];
  List<ActivityModel> _allActivityItem = [];

  ///* Get Date From SelectedActivityItem in Flutter Calendar
  ///* Date will change depending you tap date => 12 march , 14 march
  DateTime get dateSelectedActivityItem => _dateSelectedActivityItem;

  ///* Get Date From CupertinoDatePicker on AddActivityScreen
  DateTime get selectedDateFromCupertinoDatePicker =>
      _selectedDateFromCupertinoDatePicker;

  ///* Mininum Date CupertinoDatePicker
  DateTime get minDateCupertino => _minDateCupertino;

  ///* initial Date CupertinoDatePicker
  DateTime get initialDateCupertino => _initialDateCupertino;

  ///* all activity will collected depending on the Date
  /// 12-20-1999:['Berkuda','Berenang','Bertemu Mantan']
  Map<DateTime, List<ActivityModel>> get activityBasedOnDate =>
      _activityBasedOnDate;

  /// Get Top Ten Nearby Activity, it will start from DateTime.now() so on limited only 10 activity
  /// Example => 29 Maret 2020 06.00,29 Maret 2020 08.30,29 Maret 2020 08.50 ,29 Maret 2020 16.00
  List<ActivityModel> get nearby10ActivityItem => [..._nearby10ActivityItem];

  /// Get List Activity based on the Date
  List<ActivityModel> get selectedActivityItem => [..._selectedActivityItem];

  /// Get Unfinished Activity
  List<ActivityModel> get unFinishedActivity => [..._unFinishedActivityItem];

  /// Get All Activity (Unfinished and finished Activity)
  List<ActivityModel> get allActivity => [..._allActivityItem];

  /// This function for Give Value to initialDate and MinumumDate CUPERTINO DATEPICKER
  /// this function is used on the page [ActivityCalendar & OperationCalendarList]
  void setDateCupertinoDatePicker({
    DateTime initialDateCupertino,
    DateTime minDateCupertino,
  }) {
    _initialDateCupertino = initialDateCupertino;
    _minDateCupertino = minDateCupertino;

    /// Memberi Nilai Ke Tanggal Cupertino DatePicker
    setSelectedDateFromCupertinoDatePicker(initialDateCupertino);
    notifyListeners();
  }

  /// This Function for collect list and date activity to selectedActivity and dateselectedactivityitem variable
  void setSelectedListAndDateActivity({
    List<ActivityModel> selectedActivity,
    DateTime dateSelectedActivityItem,
  }) {
    _selectedActivityItem = selectedActivity;
    _dateSelectedActivityItem = dateSelectedActivityItem;
    notifyListeners();
  }

  /// Save Date From CupertinoDatePicker where user choose date & time
  void setSelectedDateFromCupertinoDatePicker(DateTime selectedDate) {
    _selectedDateFromCupertinoDatePicker = selectedDate;
    notifyListeners();
  }

  /// Reset value from CupertinoDatePicker
  void resetSelectedDateFromCupertinoDatePicker() {
    _selectedDateFromCupertinoDatePicker = null;
  }

  /// Sorting selected activity based on date and status activity (From 0 => 24 And Unfinished => finished Activity). ASCENDING
  void sortSelectedItemActivity() {
    _selectedActivityItem
        .sort((a, b) => a.dateTimeActivity.compareTo(b.dateTimeActivity));
    _selectedActivityItem
        .sort((a, b) => a.isDoneActivity.compareTo(b.isDoneActivity));
  }

  /// Addung Activity Function
  Future<void> addingActivity({
    @required String titleActivity,
    @required String dateTimeActivity,
    @required int isDoneActivity,
    @required int codeIconActivity,
    @required String informationActivity,
    @required String createdDateActivity,
  }) async {
    try {
      final lastId = await db.getLastInsertIdActivity();
      final newActivity = ActivityModel(
        idActivity: lastId,
        titleActivity: titleActivity,
        dateTimeActivity: dateTimeActivity,
        isDoneActivity: isDoneActivity,
        codeIconActivity: codeIconActivity,
        informationActivity: informationActivity,
        createdDateActivity: createdDateActivity,
      );
      await db.insertActivity(newActivity);

      /// Insert Data To All Activity List
      _unFinishedActivityItem.add(newActivity);

      /// Adding Activity To SelectedActivity
      _selectedActivityItem.add(newActivity);

      /// Load Data From SQFLite
      _nearby10ActivityItem = await db.fetch10Activity();

      /// Refresh Count In Calendar
      _activityBasedOnDate = await getActivityBasedOnDate();

      /// Sorting The SelectedItem
      sortSelectedItemActivity();

      /// Reset Calendar
      resetSelectedDateFromCupertinoDatePicker();

      /// Update The UI
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> updateActivity({
    @required String titleActivity,
    @required String dateTimeActivity,
    @required String informationActivity,
    @required int codeIconActivity,
    @required int idActivity,
  }) async {
    await db.updateActivity(
      titleActivity: titleActivity,
      dateTimeActivity: dateTimeActivity,
      informationActivity: informationActivity,
      idActivity: idActivity,
      codeIconActivity: codeIconActivity,
    );

    /// Mencari SelectedActivity Item Berdasarkan IDnya, Ketika sudah ketemu update valuenya berdarkan property yang ada.
    _selectedActivityItem
        .where((where) => where.idActivity == idActivity)
        .forEach((value) {
      value.titleActivity = titleActivity;
      value.dateTimeActivity = dateTimeActivity;
      value.informationActivity = informationActivity;
      value.codeIconActivity = codeIconActivity;
    });

    /// Sorting SelectedItemActivity
    sortSelectedItemActivity();
    notifyListeners();
  }

  ///Mendapatkan seluruh Aktifitas baik yang sudah selesai maupun yang belum selesai
  Future<void> getAllActivity() async {
    final getAllActivity = await db.fetchAllActivity();
    _allActivityItem = getAllActivity;
    notifyListeners();
  }

  /// Fungsi Untuk Mendapatkan Aktifitas yang belum selesai
  Future<void> getUnFinishedActivity() async {
    final getUnFinishedActivity = await db.fetchUnfinishedActivity();
    _unFinishedActivityItem = getUnFinishedActivity;
    notifyListeners();
  }

  ///Mendapatkan 10 Aktifitas Diurutkan  Mulai Dari Hari ini sampai selanjutnya
  Future<void> getNearby10Activity() async {
    final getNearby10ActivityFromSqflite = await db.fetch10Activity();
    _nearby10ActivityItem = getNearby10ActivityFromSqflite;
    notifyListeners();
  }

  /// Fungsi Untuk melakukan Update pada aktifitas jika checkbox ditekan, Walaupun aktifitas belum lewat tanggal  , masih tetap bisa diupdate aktifitasnya
  /// Cari Berdasarkan Statusnya = 0 dan idActivitynya sama dengan yang di select
  /// Lalu Urutkan List berdasarkan tanggal dan status ASCENDING, diurutkan berdasarkan status apabila ada kasus terdapat 3 aktifitas apabila hanya diurutkan berdasarkan
  /// tanggal saja , aktifitas yang masih belum selesai (status=0) akan ikut terurut kebawah karena pengurutan hanya berdasarkan tanggal.
  Future<void> updateStatusOnTapCheckBox(int idActivity, bool value) async {
    /// Menconvert Status dari INT ke Bool, Karena SQFLite tidak support boolean
    final result = value ? 1 : 0;

    /// Update Status saat tekan checkbox
    await db.updateStatusActivityOnTapCheckBox(idActivity, result);

    /// Refresh 10 Aktifitas Terdekat dan Jumlah Aktifitas pada kalendar
    _activityBasedOnDate = await getActivityBasedOnDate();
    _nearby10ActivityItem = await db.fetch10Activity();

    final selectedCheckBoxItem = _selectedActivityItem.where((element) {
      return element.isDoneActivity == 0 && element.idActivity == idActivity;
    }).toList();

    if (selectedCheckBoxItem == null) {
      print('Nulled');
      return;
    } else {
      /// Update SelectedItem Status
      selectedCheckBoxItem.forEach((e) => e.isDoneActivity = result);

      /// Sorting The SelectedItem
      sortSelectedItemActivity();
    }
    notifyListeners();
  }

  Future<void> updateStatusWhenDatePassed() async {
    await db.updateStatusActivityWhenDatePassed();
    _nearby10ActivityItem = await db.fetch10Activity();
    _activityBasedOnDate = await getActivityBasedOnDate();

    /// Untuk Mendapatkan Aktifitas Yang Tanggal dan waktunya melewati Tanggal dan Waktu Sekarang
    final passedDateItem = _selectedActivityItem.where((element) {
      DateTime convertStringToDateTime =
          DateTime.parse(element.dateTimeActivity);
      return convertStringToDateTime.isBefore(DateTime.now());
    });

    /// Pengecekan Apakah Aktifitasnya ditemukan/tidak
    if (passedDateItem == null) {
      print('Nulled');
      return;
    } else {
      /// Option 1
      /// Melakukan Update aktifitas Menjadi selesai
      /// Hati Hati , Memungkinkan menghadapi masalah performance issue ketika menggunakan script dibawah ini. Masih Mencari Script yang lebih baik dari ini.
      passedDateItem.forEach((e) => e.isDoneActivity = 1);
      print('Haloooooooooo ${passedDateItem.length}');

      // / Option 2
      // for (var activityModel in passedDateItem) {
      //   activityModel.isDoneActivity = 1;
      // }

      /// Sorting The SelectedItem
      sortSelectedItemActivity();
    }

    notifyListeners();
  }

  Future<void> deleteActivityById(int idActivity) async {
    await db.deleteActivityByIdActivity(idActivity);

    ///Refresh Activity
    _nearby10ActivityItem = await db.fetch10Activity();
    _activityBasedOnDate = await getActivityBasedOnDate();

    /// Hapus SelectedActivityItem
    _selectedActivityItem
        .removeWhere((element) => element.idActivity == idActivity);
  }

  ///Mendapatkan Object<10-10-1999,['Berlatih Berkuda','Bermain piano','Bergulat']> berdasarkan tanggalnya.
  Future<Map<DateTime, List<ActivityModel>>> getActivityBasedOnDate() async {
    try {
      /// Initialize Empty Map
      Map<DateTime, List<ActivityModel>> mapFetch = {};

      /// Get All Activity
      List<ActivityModel> resultActivityList = await db.fetchAllActivity();

      /// Looping Based On List Activity Length
      for (int i = 0; i < resultActivityList.length; i++) {
        ///Convert Date From String To DateTime, Because SQFLite not supported DATETIME Type
        DateTime convertDateActivityFromStringToDateTime =
            DateTime.parse(resultActivityList[i].dateTimeActivity);

        /// initialize Date
        final dateActivity = DateTime(
          convertDateActivityFromStringToDateTime.year,
          convertDateActivityFromStringToDateTime.month,
          convertDateActivityFromStringToDateTime.day,
        );
        final original = mapFetch[dateActivity];
        if (original == null) {
          mapFetch[dateActivity] = [resultActivityList[i]];
        } else {
          mapFetch[dateActivity] = List.from(original)
            ..addAll([resultActivityList[i]]);
        }
      }
      _activityBasedOnDate = mapFetch;
      notifyListeners();
      return mapFetch;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
