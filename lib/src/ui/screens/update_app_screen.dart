import 'package:atur_semua_aktifitas/src/function/go_to.dart';
import 'package:atur_semua_aktifitas/src/ui/variable/colors/color_pallete.dart';
import 'package:atur_semua_aktifitas/src/ui/variable/sizes/sizes.dart';
import 'package:atur_semua_aktifitas/src/ui/widgets/button_custom.dart';
import 'package:flutter/material.dart';

class UpdateAppScreen extends StatefulWidget {
  @override
  _UpdateAppScreenState createState() => _UpdateAppScreenState();
}

class _UpdateAppScreenState extends State<UpdateAppScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  Animation<double> _imageAnimation;
  Animation<double> _buttonAnimation;
  AnimationController _imageController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _imageController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _imageAnimation = Tween<double>(begin: 0, end: 600.0).animate(
      CurvedAnimation(
        parent: _imageController,
        curve: Curves.slowMiddle,
      ),
    );
    _buttonAnimation = Tween<double>(begin: 1.0, end: 0).animate(
      CurvedAnimation(
        curve: Curves.fastOutSlowIn,
        parent: _imageController,
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _imageController.reverse();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: sizes.height(context) / 6,
              left: sizes.width(context) / 12,
            ),
            child: Text(
              'Pembaharuan Aplikasi Tersedia',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorPallete.greyTransparent,
                  fontSize: 20),
            ),
          ),
          AnimatedBuilder(
            animation: _imageController,
            builder: (context, child) => Opacity(
              opacity: _buttonAnimation.value,
              child: child,
            ),
            child: Container(
              margin: EdgeInsets.only(top: sizes.height(context) / 4),
              alignment: Alignment.center,
              child: Card(
                margin:
                    EdgeInsets.symmetric(horizontal: sizes.width(context) / 15),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(5),
                    bottom: Radius.circular(25),
                  ),
                ),
                child: Container(
                  height: sizes.height(context) / 2.25,
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ButtonCustom(
                        onPressed: () => Navigator.of(context).pop(true),
                        buttonSize: 2.5,
                        padding: EdgeInsets.all(4),
                        buttonTitle: 'Keluar',
                      ),
                      ButtonCustom(
                        onPressed: () {
                          _imageController.forward();
                          goTo.gotoPlaystore();
                        },
                        buttonSize: 2.5,
                        padding: EdgeInsets.all(4),
                        buttonTitle: 'Menuju Playstore',
                        buttonColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          buildAnimatedRocket(context),
        ],
      ),
    );
  }

  AnimatedBuilder buildAnimatedRocket(BuildContext context) {
    return AnimatedBuilder(
      animation: _imageController,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          bottom: _imageAnimation.value,
          top: sizes.height(context) / 12,
        ),
        child: Image.asset(
          'assets/images/update_app.png',
          height: sizes.height(context) / 2.5,
        ),
      ),
      builder: (context, child) => Container(
        margin: EdgeInsets.only(
          bottom: _imageAnimation.value,
        ),
        child: child,
      ),
    );
  }
}
