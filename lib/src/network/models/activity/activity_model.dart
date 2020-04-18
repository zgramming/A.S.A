class ActivityModel {
  int idActivity;
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

  ActivityModel.fromSqflite(Map<String, dynamic> json)
      : idActivity = json['id_activity'],
        titleActivity = json['title_activity'],
        dateTimeActivity = json['datetime_activity'],
        isDoneActivity = json['is_done_activity'],
        codeIconActivity = json['code_icon_activity'],
        informationActivity = json['information_activity'],
        createdDateActivity = json['created_date'];

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
