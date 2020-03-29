import 'package:flutter/material.dart';

import '../variable/colors/color_pallete.dart';
import '../variable/sizes/sizes.dart';

import '../../function/open_social_media.dart';
import '../../network/models/profil/profil_model.dart';

class AboutMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: profilList.map<Widget>(
          (profil) {
            final String letterOne = profil.firstName.substring(0, 1);
            final String letterTwo = profil.lastName.substring(0, 1);
            return Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
                Container(
                  width: sizes.width(context) / 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '$letterOne$letterTwo',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: colorPallete.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(profil.fullname),
                Divider(
                  color: colorPallete.dividerDynamicColor(context),
                  indent: sizes.width(context) / 10,
                  endIndent: sizes.width(context) / 10,
                  thickness: 1.25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    circleSocialMedia(
                      context: context,
                      color: profil.colorLinkedIn,
                      urlImage: profil.imageUrlLinkedIn,
                      urlSocialMedia: profil.urlLinkedIn,
                    ),
                    circleSocialMedia(
                      context: context,
                      color: profil.colorGithub,
                      urlImage: profil.imageUrlGithub,
                      urlSocialMedia: profil.urlGithub,
                    ),
                    circleSocialMedia(
                      context: context,
                      color: profil.colorGmail,
                      urlImage: profil.imageUrlGmail,
                      urlSocialMedia: profil.urlGmail,
                      isEmail: true,
                      emailTo: profil.urlGmail,
                    ),
                    circleSocialMedia(
                      context: context,
                      color: profil.colorFacebook,
                      urlImage: profil.imageUrlFacebook,
                      urlSocialMedia: profil.urlFacebook,
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            );
          },
        ).toList(),
      ),
    );
  }

  Widget circleSocialMedia({
    @required BuildContext context,
    @required Color color,
    @required String urlImage,
    @required String urlSocialMedia,
    bool isEmail = false,
    String emailTo = '',
  }) =>
      InkWell(
        onTap: () => openSocialMedia.openSocialMedia(
          urlSocialMedia: urlSocialMedia,
          isEmail: isEmail,
          emailTo: emailTo,
        ),
        child: CircleAvatar(
          backgroundColor: color,
          radius: sizes.width(context) / 15,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              urlImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
}
