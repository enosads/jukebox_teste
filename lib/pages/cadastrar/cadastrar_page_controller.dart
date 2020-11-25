import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukebox_teste/pages/perfil/perfil_page.dart';
import 'package:jukebox_teste/pages/perfil/usuario_api.dart';
import 'package:jukebox_teste/pages/perfil/usuario_controller.dart';
import 'package:jukebox_teste/utils/api_response.dart';
import 'package:jukebox_teste/widgets/app_dialog.dart';

class CadastrarPageController extends GetxController {
  TextEditingController tRepetirSenha;
  final formKeySenha = GlobalKey<FormState>(debugLabel: 'senha');
  final cadastrarPressed = false.obs;
  ApiResponse<bool> response;
  final obscureTextSenha = true.obs;
  final obscureTextRepetirSenha = true.obs;
  TextEditingController tSenha = TextEditingController(text: '');
  TextEditingController tConfirmarSenha = TextEditingController(text: '');

  CadastrarPageController get to => Get.find();
  TextEditingController tEmail;

  TextEditingController tNome;

  final dataNascimento = DateTime.now().subtract(Duration(days: 18 * 365)).obs;

  @override
  void onInit() {
    tEmail = TextEditingController(text: '');
    tNome = TextEditingController(text: '');
    tSenha = TextEditingController(text: '');
    tConfirmarSenha = TextEditingController(text: '');
    super.onInit();
  }

  var formKey = GlobalKey<FormState>();
  var loading = false.obs;

  onClickCadastrar() async {
    cadastrarPressed.value = true;
    if (formKeySenha.currentState.validate() &&
        formKey.currentState.validate()) {
      var response = await UsuarioApi.verificarEmailCadastrado(tEmail.text);
      if (response.ok) {
        if (response.result == null) {
          ApiResponse<bool> r = await UsuarioApi.cadastrar(tNome.text,
              tEmail.text, tSenha.text, dataNascimento.value.toString());

          if (r.ok) {
            var r = await UsuarioApi.login(tEmail.text, tSenha.text);
            if (r.ok) {
              await UsuarioController.to.save(r.result);
              Get.offAll(PerfilPage());
            } else {
              AppDialog(
                Text(r.msg),
                confirmColor: Colors.blue,
                textConfirm: 'ok',
                onConfirm: () => Get.back(),
              ).show();
            }
          } else {
            AppDialog(
              Text(response.msg),
              confirmColor: Colors.blue,
              textConfirm: 'ok',
              onConfirm: () => Get.back(),
            ).show();
          }
        } else {
          AppDialog(
            Text('Já existe uma conta com este email.'),
            confirmColor: Colors.blue,
            textConfirm: 'ok',
            onConfirm: () => Get.back(),
          ).show();
        }
      } else {
        AppDialog(
          Text(response.msg),
          confirmColor: Colors.blue,
          textConfirm: 'ok',
          onConfirm: () => Get.back(),
        ).show();
      }
      cadastrarPressed.value = false;
    }
  }

  String validateSenha(String value) {
    if (value.isEmpty) {
      return 'Este campo não pode está em branco.';
    } else if (value.length < 8) {
      return 'A senha deve ter no mínimo 8 caracteres.';
    } else if (tSenha.text != tConfirmarSenha.text) {
      return 'As senhas são diferentes';
    }
    return null;
  }

  String validateRepetirSenha(String value) {
    if (tConfirmarSenha.text.isEmpty) {
      return 'Este campo não pode está em branco.';
    } else if (tSenha.text != tConfirmarSenha.text) {
      return 'As senhas são diferentes';
    }
    return null;
  }

  String validateEmail(String value) {
    print(!EmailValidator.validate(value));
    if (!EmailValidator.validate(value)) {
      return 'Digite um email válido';
    }
    return null;
  }

  void onPressedObscureSenha() {
    obscureTextSenha.value = !obscureTextSenha.value;
  }

  void onPressedObscureRepetirSenha() {
    obscureTextRepetirSenha.value = !obscureTextRepetirSenha.value;
  }
}
