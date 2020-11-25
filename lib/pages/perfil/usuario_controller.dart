import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukebox_teste/models/usuario_model.dart';
import 'package:jukebox_teste/pages/login/login_page.dart';
import 'package:jukebox_teste/pages/login/login_page_controller.dart';
import 'package:jukebox_teste/pages/perfil/usuario_api.dart';
import 'package:jukebox_teste/pages/splash/splash_page_controller.dart';
import 'package:jukebox_teste/utils/prefs.dart';
import 'package:jukebox_teste/utils/singleton.dart';
import 'package:jukebox_teste/widgets/app_dialog.dart';

class UsuarioController extends GetxController {
  static UsuarioController get to => Get.find();
  Usuario usuario;
  bool splash;

  @override
  void onInit() {
    splash = true;
    getUsuario();
  }

  getUsuario() async {
    usuario = Usuario();
    String id = await Prefs.getString('usuario.id');
    usuario.id = id != null ? id : '';
    bool r = false;
    if (usuario.id.isNotEmpty) {
      var response = await UsuarioApi.loginId(usuario.id);
      if (response.ok) {
        usuario = response.result;
        r = true;
      } else {
        try {
          LoginPageController.to;
          Get.back();
        } catch (error) {
          Get.offAll(LoginPage());
        }
        usuario = null;
        r = false;
      }
    } else {
      usuario = null;
      r = false;
    }
    if (splash == true) {
      if (await Factory.getHash() == '') {
        AppDialog(
          Text('O HASH não foi inserido.'),
          textConfirm: 'Ok',
          onConfirm: () => Get.back(),
        ).show();
      } else {
        SplashPageController.to.usuarioCarregado.value = true;
        splash = false;
      }
      update();
      return r;
    }
  }

  Future<bool> save(Usuario u) async {
    usuario = u;
    await Prefs.setString('usuario.id', u.id);
    return true;
  }

  Future<bool> clear() async {
    usuario = null;
    await Prefs.setString('usuario.id', '');
    return true;
  }

  onRefresh() async {
    await getUsuario();
    update();
    return;
  }
}
