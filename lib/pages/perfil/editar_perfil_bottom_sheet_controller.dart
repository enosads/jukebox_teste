import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jukebox_teste/pages/perfil/usuario_api.dart';
import 'package:jukebox_teste/pages/perfil/usuario_controller.dart';
import 'package:jukebox_teste/utils/api_response.dart';
import 'package:jukebox_teste/widgets/app_dialog.dart';

class EditarPerfilBottomSheetController extends GetxController {
  TextEditingController tNome;
  TextEditingController tEmail;
  TextEditingController tSenhaAnterior;
  TextEditingController tNovaSenha;
  final obscureTextSenhaAnterior = true.obs;
  final obscureTextNovaSenha = true.obs;

  ApiResponse<bool> response;
  final formKey = GlobalKey<FormState>();
  FocusNode focusEmail;
  final salvarPressed = false.obs;

  final dataNascimento = UsuarioController.to.usuario.dataNascimento.obs;

  static EditarPerfilBottomSheetController get to => Get.find();

  @override
  void onInit() {
    focusEmail = FocusNode();
    resetTextPerfil();
  }

  resetTextPerfil() {
    tNome = TextEditingController(
      text: UsuarioController.to.usuario.nome,
    );
    tEmail = TextEditingController(text: UsuarioController.to.usuario.email);
    tSenhaAnterior = TextEditingController();
    tNovaSenha = TextEditingController(text: '');
  }

  String validateSenha(String value) {
    if (value.isEmpty) {
      return 'Este campo não pode está em branco.';
    } else if (value.length < 8) {
      return 'A senha deve ter no mínimo 8 caracteres.';
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

  void onPressedObscureSenhaAnterior() {
    obscureTextSenhaAnterior.value = !obscureTextSenhaAnterior.value;
  }

  void onPressedObscureNovaSenha() {
    obscureTextNovaSenha.value = !obscureTextNovaSenha.value;
  }

  onClickSalvar() async {
    salvarPressed.value = true;
    if (formKey.currentState.validate()) {
      if (tEmail.text != UsuarioController.to.usuario.email) {
        var response = await UsuarioApi.verificarEmailCadastrado(tEmail.text);
        if (response.ok) {
          if (response.result == null) {
            await cadastrar();
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
      } else {
        await cadastrar();
      }
    }

    salvarPressed.value = false;
  }

  Future cadastrar() async {
    if (md5.convert(utf8.encode(tSenhaAnterior.text)).toString() ==
        UsuarioController.to.usuario.senha) {
      String date =
          "${dataNascimento.value.year}-${dataNascimento.value.month}-${dataNascimento.value.day}";
      response = await UsuarioApi.update(UsuarioController.to.usuario.id,
          tNome.text, tEmail.text, tNovaSenha.text, date);
      if (response.ok) {
        UsuarioController.to.getUsuario();
        Get.back();
        AppDialog(
          Text('Perfil salvo com sucesso.'),
          onConfirm: () => Get.back(),
          textConfirm: "Ok",
        ).show();
      } else {
        formKey.currentState.validate();
      }
    } else {
      AppDialog(
        Text('A senha anterior está incorreta'),
        onConfirm: () => Get.back(),
        textConfirm: "Ok",
      ).show();
    }
  }
}
