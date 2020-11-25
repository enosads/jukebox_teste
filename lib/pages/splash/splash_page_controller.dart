import 'package:jukebox_teste/pages/login/login_page.dart';
import 'package:jukebox_teste/pages/perfil/perfil_page.dart';
import 'package:jukebox_teste/pages/perfil/usuario_controller.dart';
import 'package:get/get.dart';

class SplashPageController extends GetxController {
  static SplashPageController get to => Get.find();
  final usuarioCarregado = false.obs;

  @override
  void onInit() {
    super.onInit();
    ever(usuarioCarregado, (usuarioCarregado) {
      if (usuarioCarregado) {
        if (UsuarioController.to.usuario != null) {
          Get.off(PerfilPage());
        } else {
          Get.off(LoginPage());
        }
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    UsuarioController.to.splash = false;
  }
}
