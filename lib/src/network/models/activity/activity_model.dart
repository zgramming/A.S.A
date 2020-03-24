class ActivityModel {
  String idActivity;
  String titleActivity;
  String dateTimeActivity;
  int isDoneActivity;
  int codeIconActivity;
  String informationActivity;
  String createdDateActivity;

  ActivityModel({
    this.idActivity,
    this.titleActivity,
    this.dateTimeActivity,
    this.isDoneActivity,
    this.codeIconActivity,
    this.informationActivity,
    this.createdDateActivity,
  });

  ActivityModel.fromSqflite(Map<String, dynamic> map)
      : idActivity = map['id_activity'],
        titleActivity = map['title_activity'],
        dateTimeActivity = map['datetime_activity'],
        isDoneActivity = map['is_done_activity'],
        codeIconActivity = map['code_icon_activity'],
        informationActivity = map['information_activity'],
        createdDateActivity = map['created_date'];

  Map<String, dynamic> toMapForSqflite() {
    return {
      'id_activity': this.idActivity,
      'title_activity': this.titleActivity,
      'datetime_activity': this.dateTimeActivity,
      'is_done_activity': this.isDoneActivity,
      'code_icon_activity': this.codeIconActivity,
      'information_activity': this.informationActivity,
      'created_date': this.createdDateActivity,
    };
  }
}
