import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:launch_review/launch_review.dart';
import 'package:system_setting/system_setting.dart';

import '../../providers/category_provider.dart';
import '../../providers/app_theme_provider.dart';
import '../../providers/global_provider.dart';

import '../widgets/about_me.dart';
import '../widgets/button_custom.dart';
import '../screens/add_category.dart';
import '../variable/config/app_config.dart';
import '../variable/colors/color_pallete.dart';
import '../widgets/edit_category.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).platformBrightness);
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Text(
                  'Utama',
                  style: TextStyle(
                      fontSize: 18.0, color: colorPallete.greyTransparent),
                ),
                Divider(color: colorPallete.dividerDynamicColor(context)),
                SizedBox(height: 5),
                Card(
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: <Widget>[
                      listTileSettings(
                        onTap: () => showBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(40),
                            ),
                          ),
                          builder: (smbContext) {
                            return AddCategory();
                          },
                        ),
                        context: context,
                        icon: Icons.add,
                        title: 'Tambah Kategori',
                        subtitle:
                            'Kamu Bisa Menambahkan Kategori Sesuai Keinginanmu',
                      ),
                      Divider(color: colorPallete.dividerDynamicColor(context)),
                      Consumer<AppThemeProvider>(
                        builder: (_, atProvider, __) => listTileSettings(
                          context: context,
                          icon: atProvider.isDarkMode
                              ? Icons.brightness_3
                              : Icons.wb_sunny,
                          title: 'Tema Aplikasi',
                          subtitle: 'Atur Tema Aplikasimu',
                          trailing: Switch.adaptive(
                            value: atProvider.isDarkMode,
                            onChanged: (value) => atProvider.setAppTheme(value),
                          ),
                        ),
                      ),
                      Divider(color: colorPallete.dividerDynamicColor(context)),
                      Consumer<CategoryProvider>(
                        builder: (_, ctgProvider, __) => listTileSettings(
                          icon: Icons.category,
                          enabled: ctgProvider.allCategoryItem.length == 0
                              ? false
                              : true,
                          title: 'Ubah Kategori',
                          subtitle: 'Ubah Nama atau Icon Kategorimu',
                          context: context,
                          onTap: ctgProvider.allCategoryItem.length == 0
                              ? null
                              : () => showBottomSheet(
                                    context: context,
                                    builder: (smbContext) => EditCategory(),
                                  ),
                        ),
                      ),
                      Divider(color: colorPallete.dividerDynamicColor(context)),
                      listTileSettings(
                        icon: Icons.notification_important,
                        title: "Notifikasi Setting",
                        subtitle:
                            "Membuka notifikas setting untuk konfigurasi suara,getaran,dan LED",
                        context: context,
                        onTap: () =>
                            SystemSetting.goto(SettingTarget.NOTIFICATION),
                      ),
                      Divider(color: colorPallete.dividerDynamicColor(context)),
                      listTileSettings(
                        icon: Icons.supervised_user_circle,
                        title: 'Tentang Pengembang',
                        subtitle: 'Informasi Tentang Pengembang Aplikasi',
                        context: context,
                        onTap: () => showBottomSheet(
                          context: context,
                          builder: (sbmContext) => AboutMe(),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Consumer<GlobalProvider>(
            builder: (_, gProvider, __) => ButtonCustom(
              buttonColor: Theme.of(context).accentColor,
              buttonTitle: appConfig.buttonTitleReviewUs,
              onPressed: () =>
                  LaunchReview.launch(androidAppId: gProvider.projectAppID),
            ),
          ),
        ),
      ],
    );
  }

  InkWell listTileSettings({
    @required IconData icon,
    @required String title,
    @required String subtitle,
    @required BuildContext context,
    bool enabled = true,
    Widget trailing,
    Function onTap,
  }) =>
      InkWell(
        onTap: onTap,
        child: ListTile(
          enabled: enabled,
          leading: CircleAvatar(
            backgroundColor: colorPallete.cardDynamicColor(context),
            child: Icon(
              icon,
              color:
                  colorPallete.circleAvatarIconDynamicColor(context: context),
            ),
          ),
          title: Text(title),
          subtitle: Text(
            subtitle,
            style: TextStyle(fontSize: 12.0),
          ),
          trailing: trailing,
        ),
      );
}
