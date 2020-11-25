import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:jukebox_teste/pages/perfil/editar_perfil_bottom_sheet_controller.dart';
import 'package:jukebox_teste/pages/perfil/usuario_controller.dart';
import 'package:jukebox_teste/widgets/app_bottom_sheet.dart';
import 'package:jukebox_teste/widgets/app_button.dart';
import 'package:jukebox_teste/widgets/app_text.dart';
import 'package:jukebox_teste/widgets/tile.dart';

class EditarPerfilBottomSheet {
  static show() {
    Get.bottomSheet(
        GetBuilder<EditarPerfilBottomSheetController>(
          init: EditarPerfilBottomSheetController(),
          builder: (_) {
            return Form(
              key: _.formKey,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Obx(
                    () => _.salvarPressed.value
                        ? Container(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          )
                        : GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(color: Colors.transparent)),
                  ),
                  AppBottomSheet(
                    title: 'Editar Perfil',
                    child: Column(
                      children: [
                        Tile(
                          title: AppText(
                            controller: _.tNome,
                            label: 'Nome',
                            nextFocus: _.focusEmail,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        Tile(
                          title: AppText(
                            controller: _.tEmail,
                            label: 'E-mail',
                            focusNode: _.focusEmail,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            validator: _.validateEmail,
                          ),
                        ),
                        Tile(
                          title: Stack(
                            children: [
                              AppText(
                                controller: TextEditingController(text: '.'),
                                label: 'Data de nascimento',
                                readOnly: true,
                                color: Colors.white,
                              ),
                              Container(
                                width: Get.width,
                                height: 47,
                                color: Colors.transparent,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 18),
                                child: DateTimePicker(
                                  locale: Locale('pt', 'BR'),
                                  type: DateTimePickerType.date,
                                  initialValue: UsuarioController
                                      .to.usuario.dataNascimento
                                      .toString(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now()
                                      .subtract(Duration(days: 18 * 365)),
                                  onChanged: (val) => _.dataNascimento.value =
                                      DateTime.parse(val),
                                  dateMask: 'dd/MM/yyyy',
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(
                          () => Container(
                            margin: EdgeInsets.symmetric(horizontal: 24),
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                AppText(
                                  hint: 'Senha anterior',
                                  controller: _.tSenhaAnterior,
                                  password: _.obscureTextSenhaAnterior.value,
                                  validator: _.validateSenha,
                                ),
                                Container(
                                  child: IconButton(
                                    icon: Icon(_.obscureTextSenhaAnterior.value
                                        ? LineAwesomeIcons.eye_slash
                                        : LineAwesomeIcons.eye),
                                    onPressed: _.onPressedObscureSenhaAnterior,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Obx(
                          () => Container(
                            margin: EdgeInsets.symmetric(horizontal: 24),
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                AppText(
                                  hint: 'Nova senha',
                                  controller: _.tNovaSenha,
                                  password: _.obscureTextNovaSenha.value,
                                  validator: _.validateSenha,
                                ),
                                Container(
                                  child: IconButton(
                                    icon: Icon(_.obscureTextNovaSenha.value
                                        ? LineAwesomeIcons.eye_slash
                                        : LineAwesomeIcons.eye),
                                    onPressed: _.onPressedObscureNovaSenha,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Tile(
                          title: Obx(
                            () => AppButton(
                              'Salvar ',
                              color: Colors.blue,
                              textColor: Colors.white,
                              onPressed: _.salvarPressed.value
                                  ? null
                                  : () => _.onClickSalvar(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent);
  }
}
