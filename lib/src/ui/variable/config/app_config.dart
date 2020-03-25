class AppConfig {
  final String tableCategory = 'tbl_category';
  final String tableActivity = 'tbl_activity';
  final String tableAppTheme = 'tbl_app_theme';

  final String indonesiaLocale = 'id_ID';
  final String onProgress = 'On Progress';
  final String isDone = 'Done';

  /// Add Category Screen
  final String pickIcon = 'Pick Icon';
  final String fontFamilyIcon = 'MaterialIcons';
  final String noResultIconText = 'Tidak Dapat Menemukan Icon';
  final String titleCategoryText = 'Nama Kategori';
  final String informationCategoryText = 'Keterangan Kategori';

  /// Add Activity Screen
  final String snackbarErrorDateText = 'ERROR : Tanggal / Waktu Sudah Lewat';
  final int durationSnackbarErrorDateText = 2;

  ///SplashScreen
  final String locationImageSplashScreen = 'assets/images/logo.png';

  ///SettingsScreen
  final String appBarTitleSettingsScreen = 'Settings';
  final String cardAppThemeText = 'Tema';
  final String cardAddCategoryText = 'Tambah Kategori';
  final String cardAboutMeText = 'Profil';
  final String buttonTitleReviewUs = 'Review Aplikasi';

  ///NearbyActivityScreen
  String appBarTitleNearbyActivityScreen(int totalActivity) =>
      '$totalActivity Aktifitas Terdekatmu Ditemukan';
  final String appBarTitleMainCalendarScreen = 'Kalendar Aktifitasmu';

  ///MainCalendarScreen
  String locationImageEmptyActivity = 'assets/images/empty-activity.png';
  String detail = 'Detail';
  String edit = 'Edit';
  String hapus = 'Hapus';
}

final appConfig = AppConfig();
