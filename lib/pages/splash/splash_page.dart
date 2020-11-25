import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukebox_teste/pages/perfil/usuario_controller.dart';
import 'package:jukebox_teste/pages/splash/splash_page_controller.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:jukebox_teste/utils/singleton.dart';
import 'package:jukebox_teste/widgets/app_dialog.dart';
import 'package:jukebox_teste/widgets/app_hash_dialog.dart';
import 'package:jukebox_teste/widgets/app_text.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(UsuarioController());
    return GetBuilder<SplashPageController>(
      init: SplashPageController(),
      builder: (_) {
        return Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              color: Colors.white,
              child: Center(
                child: Hero(
                  tag: 'hero',
                  child: CircleAvatar(
                    radius: 120.0,
                    child: Icon(
                      LineAwesomeIcons.user,
                      size: 120,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                AppHashDialog()
              ],
            ),
          ],
        );
      },
    );
  }
}
