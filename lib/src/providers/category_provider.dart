import 'package:flutter/foundation.dart';

import '../../src/network/helper/sqflite_helper.dart';
import '../../src/network/models/category/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryProvider() {
    getAllCategory();
  }

  ///Initialize DB Sqflite
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

  Future<void> addingCategory({
    @required String titleCategory,
    @required int codeIconCategory,
    @required String informationCategory,
    @required String createDate,
  }) async {
    final lastInsertId = await db.getLastInsertIdCategory();
    final newCategory = CategoryModel(
      idCategory: lastInsertId,
      titleCategory: titleCategory,
      codeIconCategory: codeIconCategory,
      informationCategory: informationCategory,
      createdDate: createDate,
    );
    await db.insertCategory(newCategory);

    /// Inserting Data Into List Category
    _allCategoryItem.add(newCategory);

    /// Sort By Descending
    _allCategoryItem.sort((a, b) => b.createdDate.compareTo(a.createdDate));

    /// After Add New Category , Reset Icon Code
    resetCodeIconFromIconPicker();

    /// Refresh UI
    notifyListeners();
  }

  Future<void> deleteCategory({@required int idCategory}) async {
    await db.deleteCategory(idCategory);

    /// Remove Category Where Idcategory =idCategory
    _allCategoryItem.removeWhere((element) => element.idCategory == idCategory);
    notifyListeners();
  }

  Future<void> updateIconCategory(int newCodeIcon, int idCategory) async {
    await db.updateIconCategory(newCodeIcon, idCategory);

    /// Find Category where idCategory =idCategory
    final result = _allCategoryItem.where((element) => element.idCategory == idCategory);

    /// After We Get it, update old icon to new icon
    result.forEach((element) => element.codeIconCategory = newCodeIcon);
    notifyListeners();
  }

  Future<void> updateCategory({
    @required int idCategory,
    @required String titleCategory,
    @required String informationCategory,
  }) async {
    await db.updateCategory(
      idCategory: idCategory,
      titleCategory: titleCategory,
      informationCategory: informationCategory,
    );

    /// Find Category where idCategory =idCategory
    final result = _allCategoryItem.where((element) => element.idCategory == idCategory);

    /// After We Get it, update Title & Information Category with new one
    result.forEach((element) {
      element.titleCategory = titleCategory;
      element.informationCategory = informationCategory;
    });

    /// Reset Show Edit Category , this function to hide Form Edit Category
    resetShowEditCategory();
    notifyListeners();
  }

  Future<void> getAllCategory() async {
    final getAllCategoryFromSqflite = await db.fetchCategory();

    /// Copy getAllCategoryFromSqflite to allCategoryItem
    _allCategoryItem = getAllCategoryFromSqflite;
    notifyListeners();
  }

  void setShowEditCategory({bool value, int index}) {
    /// Toggle To Show/Hide Form Edit Category
    _showEditCategory = !value;
    _indexEditCategory = index;
    notifyListeners();
  }

  void setCodeIconFromIconPicker(int codeIconPicker) {
    /// Get code from Icon Picker , and hold it to codeIconPicker variable
    _iconCodeFromIconPicker = codeIconPicker;
    notifyListeners();
  }

  void setSelectedIndexAndIconCodeCardCategory({
    int indexCard,
    int iconCodeCard,
  }) {
    /// This Function To get index and Code Icon from selected Card in  AddActivity Screen Icon and hold it to _selectedIconCodeCardCategory && _selectedIndexCardCategory variable
    _selectedIconCodeCardCategory = iconCodeCard;
    _selectedIndexCardCategory = indexCard;
    notifyListeners();
  }

  void resetSelectedIndexAndIconCodeCardCategory() {
    /// Reset CodeIcon and Index Card
    _selectedIconCodeCardCategory = 59566;
    _selectedIndexCardCategory = -1;
    notifyListeners();
  }

  void resetCodeIconFromIconPicker() {
    /// Reset codeIcon IconPicker
    _iconCodeFromIconPicker = 0;
  }

  void resetShowEditCategory() {
    /// Reset showEditCategory to toggle show/hide form edit category
    _showEditCategory = false;
    _indexEditCategory = -1;
  }
}
