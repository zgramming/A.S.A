import '../models/category/category_model.dart';
import '../variable/config/app_config.dart';

import '../models/activity/activity_model.dart';
import 'package:sqflite/sqflite.dart' as sql;

import 'package:path/path.dart' as path;

class DBHelper {
  Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(
      path.join(dbPath, 'oya.db'),
      onCreate: _onCreate,
      version: 1,
    );
  }

  void _onCreate(sql.Database db, int version) async {
    final sqlCreatedTableActivity = '''
    CREATE TABLE tbl_activity(
      id_activity TEXT PRIMARY KEY,
      title_activity TEXT,
      datetime_activity TEXT,
      is_done_activity INTEGER,
      code_icon_activity INTEGER,
      information_activity TEXT,
      created_date TEXT)
    ''';
    final sqlCreateTableCategory = '''
    CREATE TABLE tbl_category(
      id_category TEXT PRIMARY KEY,
      title_category TEXT,
      code_icon_category INTEGER,
      information_category TEXT,
      created_date TEXT)
    ''';

    await db.execute(sqlCreatedTableActivity);
    await db.execute(sqlCreateTableCategory);
    print('Table Has Been Created');
  }

  Future<int> insertCategory(CategoryModel model) async {
    final db = await database();
    final result = await db.insert(
        appConfig.tableCategory, model.toMapForSqflite(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    // print('result from insert category :$result');
    return result;
  }

  Future<int> deleteCategory(String idCategory) async {
    String where = 'id_category = ?';
    List<dynamic> whereArgs = [idCategory];
    final db = await database();
    final result = await db.delete(
      appConfig.tableCategory,
      where: where,
      whereArgs: whereArgs,
    );
    print('result delete Category $result');
    return result;
  }

  Future<int> updateIconCategory(int newCodeIcon, String idCategory) async {
    final db = await database();

    final result = await db.rawUpdate(
      '''
    UPDATE ${appConfig.tableCategory} SET code_icon_category = ? WHERE id_category = ?
    ''',
      [newCodeIcon, idCategory],
    );
    print('Update Icon Category');
    print(result);
    return result;
  }

  Future<int> updateCategory({
    String titleCategory,
    String informationCategory,
    String idCategory,
  }) async {
    final db = await database();
    final result = await db.rawUpdate(
      '''
    UPDATE ${appConfig.tableCategory}
    SET title_category = ? , information_category = ? 
    WHERE id_category = ? 
        ''',
      [titleCategory, informationCategory, idCategory],
    );
    print('Result update all value category = $result');
    return result;
  }

  Future<List<CategoryModel>> fetchCategory() async {
    final db = await database();
    String orderBy = 'created_date DESC';
    final result = await db.query(
      appConfig.tableCategory,
      orderBy: orderBy,
    );
    final categoryList =
        result.map((fromMap) => CategoryModel.fromSqflite(fromMap)).toList();
    // print('Result fetch Category $result');
    return categoryList;
  }

  Future<int> insertActivity(ActivityModel model) async {
    final db = await database();
    final result = await db.insert(
      appConfig.tableActivity,
      model.toMapForSqflite(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    // print('result from insert Activity :$result');
    return result;
  }

  Future<int> updateStatusActivityOnTapCheckBox(
    String idActivity,
    int valueCheckBox,
  ) async {
    int updateStatusActivity = valueCheckBox;
    final db = await database();
    final result = await db.rawUpdate('''
      UPDATE ${appConfig.tableActivity} SET is_done_activity = ? WHERE id_activity = ?
      ''', [updateStatusActivity, idActivity]);
    // print(await db.query(appConfig.tableActivity));
    return result;
  }

  Future<int> updateStatusActivityWhenDatePassed() async {
    String dateNow = DateTime.now().toString();
    int updateStatusActivity = 1;
    int oldStatusActivity = 0;
    List<dynamic> whereArgs = [
      updateStatusActivity,
      oldStatusActivity,
      dateNow
    ];
    final db = await database();
    final result = await db.rawUpdate('''
    UPDATE ${appConfig.tableActivity} SET is_done_activity = ? WHERE is_done_activity = ? AND datetime_activity < ?
    ''', whereArgs);
    // print(
    //     'Helo From UpdateStatusActivityWhenDatePassed : ${await db.query(appConfig.tableActivity)}');

    return result;
  }

  Future<int> deleteActivityByIdActivity(String idActivity) async {
    String where = 'id_activity = ?';
    List<dynamic> whereArgs = [idActivity];
    final db = await database();
    final result = await db.delete(
      appConfig.tableActivity,
      where: where,
      whereArgs: whereArgs,
    );
    print('result delete activity $result');
    return result;
  }

  Future<List<ActivityModel>> fetchUnfinishedActivity() async {
    String where = 'is_done_activity = ?';
    int isDoneActivity = 0;
    List<dynamic> whereArgs = [isDoneActivity];
    final db = await database();
    final result = await db.query(
      appConfig.tableActivity,
      where: where,
      whereArgs: whereArgs,
    );
    final activityList =
        result.map((fromMap) => ActivityModel.fromSqflite(fromMap)).toList();
    // print('Result UnFinished Activity $result');
    // result.forEach((element) => print("Unfinished Data ${element.values}"));
    return activityList;
  }

  Future<List<ActivityModel>> fetchAllActivity() async {
    final db = await database();

    /// Untuk Mengurutkan Dari Aktifitas Belum Selesai dilanjutkan Diurutkan Berdasarkan Waktunya
    String orderBy = 'is_done_activity ASC,datetime_activity ASC';
    final result = await db.query(appConfig.tableActivity, orderBy: orderBy);
    final activityList =
        result.map((fromMap) => ActivityModel.fromSqflite(fromMap)).toList();
    // print('Result All Activity $result');
    // result.forEach((elem ent) => print("All Activity Data ${element.values}"));
    return activityList;
  }

  Future<List<ActivityModel>> fetch10Activity() async {
    String dateNow = DateTime.now().toString();
    int isDoneActivity = 0;
    int limit = 10;
    String where = 'is_done_activity = ? AND datetime_activity > ? ';
    List<dynamic> whereArgs = [isDoneActivity, dateNow];
    String orderBy = 'datetime_activity ASC';
    final db = await database();
    final result = await db.query(
      appConfig.tableActivity,
      where: where,
      whereArgs: whereArgs,
      limit: limit,
      orderBy: orderBy,
    );
    final activityList =
        result.map((e) => ActivityModel.fromSqflite(e)).toList();
    result
        .forEach((element) => print("Nearby10Activity Data ${element.values}"));

    // print('From Sqflitehelper : ${result.length}');
    // print('From Sqflitehelper : ${activityList.length}');
    // print('From Sqflitehelper : $dateNow');
    return activityList;
  }
}
