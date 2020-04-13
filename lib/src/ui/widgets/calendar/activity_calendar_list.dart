import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../network/models/activity/activity_model.dart';
import '../../../providers/main_calendar_provider.dart';

import '../../template/splashscreen_template/widgets/splashscreen_image_asset.dart';
import '../../variable/colors/color_pallete.dart';
import '../../variable/config/app_config.dart';
import '../../variable/sizes/sizes.dart';

import '../operation_calendar_list.dart';

class ActivityCalendarList extends StatelessWidget {
  final List<ActivityModel> selectedActivity;
  final DateTime dateActivity;
  ActivityCalendarList({
    @required this.selectedActivity,
    @required this.dateActivity,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 24.0,
        top: 8.0,
      ),
      child: (selectedActivity.length == 0)
          ? SplashScreenImageAsset(
              locationImage: appConfig.locationImageEmptyActivity,
              imageHeight: 2.5,
            )
          : ListView.builder(
              itemCount: selectedActivity.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final result = selectedActivity[index];
                bool isDone = result.isDoneActivity == 0 ? false : true;
                DateTime convertDateActivityFromStringToDateTime =
                    DateTime.parse(result.dateTimeActivity);
                String formatTime = DateFormat.Hm()
                    .format(convertDateActivityFromStringToDateTime);
                return Card(
                  shape: Border(
                    right: BorderSide(
                      width: 5,
                      color: isDone ? Colors.green : Colors.yellow[700],
                    ),
                  ),
                  child: InkWell(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                      ),
                      builder: (smbContext) => OperationCalendarList(
                        activityModel: result,
                      ),
                    ),
                    child: ListTile(
                      leading: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            formatTime,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              color: colorPallete
                                  .bottomTitleMainCalendarDynamicColor(
                                context,
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        result.titleActivity,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          decoration: isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: SizedBox(
                        height: sizes.height(context) / 20,
                        child: FittedBox(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              IconData(
                                result.codeIconActivity,
                                fontFamily: appConfig.fontFamilyIcon,
                              ),
                            ),
                          ),
                        ),
                      ),
                      trailing: Consumer<MainCalendarProvider>(
                        builder: (_, mcProvider, __) => Checkbox(
                          value: isDone,
                          onChanged: result.isDoneActivity == 1
                              ? null
                              : (value) => mcProvider.updateStatusOnTapCheckBox(
                                    result.idActivity,
                                    value,
                                  ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
