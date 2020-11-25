import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukebox_teste/pages/cadastrar/cadastrar_page.dart';
import 'package:jukebox_teste/pages/perfil/perfil_page.dart';
import 'package:jukebox_teste/pages/perfil/usuario_api.dart';
import 'package:jukebox_teste/pages/perfil/usuario_controller.dart';
import 'package:jukebox_teste/utils/prefs.dart';
import 'package:jukebox_teste/widgets/app_dialog.dart';

class LoginPageController extends GetxController {
  final obscureTextSenha = true.obs;

  static LoginPageController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    lastLogin();
  }

  var formKey = GlobalKey<FormState>();
  final tEmail = TextEditingController();
  final tSenha = TextEditingController();
  final focusSenha = FocusNode();
  var loading = false.obs;

  lastLogin() async {
    String login = await Prefs.getString('lastLogin');
    tEmail.text = login;
  }

  String validateEmail(String text) {
    if (text.isEmpty) {
      return 'Digite o email';
    }
    if (text.length < 3) {
      return 'A senha precisa ter pelo menos 3 números';
    }
    return null;
  }

  String validateSenha(String text) {
    if (text.isEmpty) {
      return 'Digite a senha';
    } else if (text.length < 8) {
      return 'A senha deve ter pelos menos 8 caracteres';
    }
    return null;
  }

  onClickLogin() async {
    bool formOk = formKey.currentState.validate();
    if (!formOk) {
      return;
    }
    var email = tEmail.text;
    var senha = tSenha.text;

    loading.value = true;
    var response = await UsuarioApi.login(email, senha);

    loading.value = false;

    if (response.ok) {
      await UsuarioController.to.save(response.result);
      Get.off(PerfilPage());
    } else {
      AppDialog(
        Text(response.msg),
        textConfirm: 'Ok',
        onConfirm: () => Get.back(),
      ).show();
    }
  }

  onClickCadastrar() {
    Get.to(CadastrarPage());
  }

  void onPressedObscureSenha() {
    obscureTextSenha.value = !obscureTextSenha.value;
  }
}
