import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:jukebox_teste/models/usuario_model.dart';
import 'package:jukebox_teste/pages/perfil/usuario_api.dart';
import 'package:jukebox_teste/utils/email_util.dart';
import 'package:jukebox_teste/utils/prefs.dart';
import 'package:jukebox_teste/widgets/app_bottom_sheet.dart';
import 'package:jukebox_teste/widgets/app_button.dart';
import 'package:jukebox_teste/widgets/app_dialog.dart';
import 'package:jukebox_teste/widgets/app_text.dart';

class RecuperarSenhaPageController extends GetxController {
  TextEditingController tEmail = TextEditingController();
  final formKeySenha = GlobalKey<FormState>(debugLabel: 'senha');
  final obscureTextSenha = true.obs;
  final obscureTextRepetirSenha = true.obs;
  Usuario usuario;
  var formKey = GlobalKey<FormState>();

  TextEditingController tCodigo = TextEditingController();

  TextEditingController tSenha = TextEditingController();
  TextEditingController tConfirmarSenha = TextEditingController();

  static RecuperarSenhaPageController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  String validateEmail(String value) {
    if (!EmailValidator.validate(value)) {
      return 'Digite um email válido';
    }
    return null;
  }

  onClickEnviarEmail() async {
    if (formKey.currentState.validate()) {
      var response = await UsuarioApi.verificarEmailCadastrado(tEmail.text);
      if (response.ok) {
        usuario = response.result;
        if (response.result != null) {
          await enviarEmail();
          Get.bottomSheet(AppBottomSheet(
            title: 'Alterar senha: ',
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  AppText(
                    label: 'Código',
                    controller: tCodigo,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  AppButton(
                    'Confirmar',
                    onPressed: () => onConfirm(),
                    color: Colors.blue,
                    textColor: Colors.white,
                  )
                ],
              ),
            ),
          ));
        } else {
          AppDialog(
            Text('Não existe conta com esse email'),
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
    }
  }

  Future enviarEmail() async {
    String codigo = Random().nextInt(999999).toString();
    await Prefs.setString('recuperarSenha', codigo);
    await EmailUtil.enviar(tEmail.text,
        'Este é o seu código para a recuperação da sua conta: \n\n$codigo');
  }

  onConfirm() async {
    if (await Prefs.getString('recuperarSenha') == tCodigo.text) {
      Get.back();
      Get.bottomSheet(AppBottomSheet(
        title: 'Alterar senha',
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Form(
                key: formKeySenha,
                child: Column(
                  children: [
                    Obx(() => Stack(
                          alignment: Alignment.topRight,
                          children: [
                            AppText(
                              controller: tSenha,
                              label: 'Nova senha',
                              onChanged: (String value) {
                                formKeySenha.currentState.validate();
                              },
                              password: obscureTextSenha.value,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              validator: validateSenha,
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 8),
                              child: IconButton(
                                icon: Icon(obscureTextSenha.value
                                    ? LineAwesomeIcons.eye
                                    : LineAwesomeIcons.eye_slash),
                                onPressed: onPressedObscureSenha,
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    Obx(
                      () => Stack(
                        alignment: obscureTextRepetirSenha.value
                            ? Alignment.topRight
                            : Alignment.centerRight,
                        children: [
                          AppText(
                            controller: tConfirmarSenha,
                            label: 'Repetir nova senha',
                            password: obscureTextRepetirSenha.value,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onChanged: (String value) {
                              formKeySenha.currentState.validate();
                            },
                            validator: validateRepetirSenha,
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 8),
                            child: IconButton(
                              icon: Icon(obscureTextRepetirSenha.value
                                  ? LineAwesomeIcons.eye
                                  : LineAwesomeIcons.eye_slash),
                              onPressed: onPressedObscureRepetirSenha,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    AppButton(
                      'Alterar',
                      onPressed: () => onClickAlterar(),
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ));
    } else {
      AppDialog(
        Text('Codigo inválido'),
        confirmColor: Colors.blue,
        textConfirm: 'ok',
        onConfirm: () => Get.back(),
      ).show();
    }
  }

  String validateSenha(String value) {
    if (value.isEmpty) {
      return 'Este campo não pode está em branco.';
    } else if (value.length < 8) {
      return 'A senha deve ter no mínimo 8 caracteres.';
    } else if (tSenha.text != tSenha.text) {
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

  void onPressedObscureSenha() {
    obscureTextSenha.value = !obscureTextSenha.value;
  }

  void onPressedObscureRepetirSenha() {
    obscureTextRepetirSenha.value = !obscureTextRepetirSenha.value;
  }

  onClickAlterar() async {
    if (formKeySenha.currentState.validate()) {
      DateTime dataNascimento = usuario.dataNascimento;
      String date =
          "${dataNascimento.year}-${dataNascimento.month}-${dataNascimento.day}";
      var r = await UsuarioApi.update(
          usuario.id, usuario.nome, usuario.email, tSenha.text, date);
      if (r.ok) {
        Get.back();
        Get.back();
        AppDialog(
          Text('Senha alterada com sucesso.'),
          onConfirm: () => Get.back(),
          textConfirm: "Ok",
        ).show();
      } else {
        formKey.currentState.validate();
      }
    }
  }
}
