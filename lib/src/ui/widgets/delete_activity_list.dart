import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../network/models/activity/activity_model.dart';
import '../../providers/main_calendar_provider.dart';

class DeleteActivityList extends StatelessWidget {
  const DeleteActivityList({
    Key key,
    @required this.activityModel,
  }) : super(key: key);

  final ActivityModel activityModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainCalendarProvider>(
      builder: (_, mcProvider, __) => AlertDialog(
        title: Text('Hapus Aktifitas ?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Batal'),
          ),
          FlatButton(
            onPressed: () {
              mcProvider.deleteActivityById(
                activityModel.idActivity,
              );
              Navigator.of(context).pop(true);
            },
            child: Text('Hapus'),
          ),
        ],
      ),
    );
  }
}
