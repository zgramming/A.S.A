class CategoryModel {
  String idCategory;
  String titleCategory;
  int codeIconCategory;
  String informationCategory;
  String createdDate;

  CategoryModel({
    this.idCategory,
    this.titleCategory,
    this.codeIconCategory,
    this.informationCategory,
    this.createdDate,
  });
  CategoryModel.fromSqflite(Map<String, dynamic> map)
      : idCategory = map['id_category'],
        titleCategory = map['title_category'],
        codeIconCategory = map['code_icon_category'],
        informationCategory = map['information_category'],
        createdDate = map['created_date'];

  Map<String, dynamic> toMapForSqflite() {
    return {
      "id_category": this.idCategory,
      "title_category": this.titleCategory,
      "code_icon_category": this.codeIconCategory,
      "information_category": this.informationCategory,
      "created_date": this.createdDate,
    };
  }
}
