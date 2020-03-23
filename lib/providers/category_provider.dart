import 'package:flutter/foundation.dart';
import '../helper/sqflite_helper.dart';
import '../models/category/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryProvider() {
    getAllCategory();
  }
  DBHelper db = DBHelper();

  /// To Toggle Visibility Edit Text On Edit Category
  bool _showEditCategory = false;

  /// Index Card For Editing
  int _indexEditCategory = -1;

  /// Icon Code From Icon Picker
  int _iconCodeFromIconPicker = 0;

  /// Default Icon if user not selected or have category icon
  int _selectedIconCodeCardCategory = 59566;
  int _selectedIndexCardCategory = -1;
  List<CategoryModel> _allCategoryItem = [];

  bool get showEditCategory => _showEditCategory;
  int get indexEditCategory => _indexEditCategory;
  int get selectedIconCodeCardCategory => _selectedIconCodeCardCategory;
  int get selectedIndexCardCategory => _selectedIndexCardCategory;
  int get iconCodeFromIconPicker => _iconCodeFromIconPicker;
  List<CategoryModel> get allCategoryItem => [..._allCategoryItem];

  setShowEditCategory(bool value, int index) {
    _showEditCategory = !value;
    _indexEditCategory = index;
    notifyListeners();
  }

  setCodeIconFromIconPicker(int codeIconPicker) {
    _iconCodeFromIconPicker = codeIconPicker;
    notifyListeners();
  }

  setSelectedIndexAndIconCodeCardCategory(
    int indexCard,
    int iconCodeCard,
  ) {
    _selectedIconCodeCardCategory = iconCodeCard;
    _selectedIndexCardCategory = indexCard;
    notifyListeners();
  }

  resetSelectedIndexAndIconCodeCardCategory() {
    _selectedIconCodeCardCategory = 59566;
    _selectedIndexCardCategory = -1;
    notifyListeners();
  }

  Future<void> addingCategory({
    @required String idCategory,
    @required String titleCategory,
    @required int codeIconCategory,
    @required String informationCategory,
    @required String createDate,
  }) async {
    final newCategory = CategoryModel(
      idCategory: idCategory,
      titleCategory: titleCategory,
      codeIconCategory: codeIconCategory,
      informationCategory: informationCategory,
      createdDate: createDate,
    );
    await db.insertCategory(newCategory);
    _allCategoryItem.add(newCategory);

    /// Sort By Descending
    _allCategoryItem.sort((a, b) => b.createdDate.compareTo(a.createdDate));
    notifyListeners();
  }

  Future<void> deleteCategory({@required String idCategory}) async {
    await db.deleteCategory(idCategory);
    _allCategoryItem.removeWhere((element) => element.idCategory == idCategory);
    notifyListeners();
  }

  Future<void> updateIconCategory(int newCodeIcon, String idCategory) async {
    await db.updateIconCategory(newCodeIcon, idCategory);
    final result =
        _allCategoryItem.where((element) => element.idCategory == idCategory);
    result.forEach((element) => element.codeIconCategory = newCodeIcon);
    notifyListeners();
  }

  Future<void> updateCategory({
    @required String idCategory,
    @required String titleCategory,
    @required String informationCategory,
  }) async {
    await db.updateCategory(
      idCategory: idCategory,
      titleCategory: titleCategory,
      informationCategory: informationCategory,
    );
    final result =
        _allCategoryItem.where((element) => element.idCategory == idCategory);
    result.forEach((element) {
      element.titleCategory = titleCategory;
      element.informationCategory = informationCategory;
    });
    notifyListeners();
  }

  Future<void> getAllCategory() async {
    final getAllCategoryFromSqflite = await db.fetchCategory();
    _allCategoryItem = getAllCategoryFromSqflite;
    notifyListeners();
  }
}
