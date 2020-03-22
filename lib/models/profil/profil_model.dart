import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfilModel {
  String firstName;
  String lastName;
  String fullname;
  String urlGithub;
  String urlLinkedIn;
  String urlGmail;
  String urlFacebook;
  Color colorLinkedIn;
  Color colorGithub;
  Color colorFacebook;
  Color colorGmail;
  String imageUrlFacebook;
  String imageUrlLinkedIn;
  String imageUrlGmail;
  String imageUrlGithub;

  ProfilModel({
    @required this.firstName,
    @required this.lastName,
    @required this.fullname,
    @required this.urlGithub,
    @required this.urlLinkedIn,
    @required this.urlGmail,
    @required this.urlFacebook,
    this.colorGithub = const Color(0xFF24292e),
    this.colorLinkedIn = const Color(0xFF2867B2),
    this.colorFacebook = const Color(0xFF4267B2),
    this.colorGmail = const Color(0xFFD44638),
    this.imageUrlFacebook = "assets/images/facebook.png",
    this.imageUrlGithub = "assets/images/github.png",
    this.imageUrlGmail = "assets/images/gmail.png",
    this.imageUrlLinkedIn = "assets/images/linkedin.png",
  });
}

List<ProfilModel> profilList = [
  ProfilModel(
    firstName: 'Zeffry',
    lastName: 'Reynando',
    fullname: 'Zeffry Reynando',
    urlGithub: 'https://github.com/zgramming',
    urlLinkedIn: 'https://www.linkedin.com/in/zeffry-reynando/',
    urlGmail: 'zeffry.reynando@gmail.com',
    urlFacebook: 'https://facebook.com/zeffry.reynando',
  ),
];
