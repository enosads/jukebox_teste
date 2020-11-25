import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:jukebox_teste/pages/cadastrar/cadastrar_page_controller.dart';
import 'package:jukebox_teste/widgets/app_button.dart';
import 'package:jukebox_teste/widgets/app_hash_dialog.dart';
import 'package:jukebox_teste/widgets/app_text.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadastrarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CadastrarPageController(),
      builder: (CadastrarPageController _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Cadastrar'),
            actions: [AppHashDialog()],
          ),
          body: Stack(
            children: <Widget>[
              Form(
                key: _.formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        controller: _.tNome,
                        label: 'Nome',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 16),
                      AppText(
                        controller: _.tEmail,
                        label: 'E-mail',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: _.validateEmail,
                      ),
                      SizedBox(height: 16),
                      Stack(
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
                              initialValue: DateTime.now()
                                  .subtract(Duration(days: 18 * 365))
                                  .toString(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now()
                                  .subtract(Duration(days: 18 * 365)),
                              onChanged: (val) =>
                                  _.dataNascimento.value = DateTime.parse(val),
                              dateMask: 'dd/MM/yyyy',
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Form(
                        key: _.formKeySenha,
                        child: Column(
                          children: [
                            Obx(() => Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    AppText(
                                      controller: _.tSenha,
                                      label: 'Senha',
                                      onChanged: (String value) {
                                        _.formKeySenha.currentState.validate();
                                      },
                                      password: _.obscureTextSenha.value,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      validator: _.validateSenha,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 8),
                                      child: IconButton(
                                        icon: Icon(_.obscureTextSenha.value
                                            ? LineAwesomeIcons.eye
                                            : LineAwesomeIcons.eye_slash),
                                        onPressed: _.onPressedObscureSenha,
                                      ),
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: 16,
                            ),
                            Obx(
                              () => Stack(
                                alignment: _.obscureTextRepetirSenha.value
                                    ? Alignment.topRight
                                    : Alignment.centerRight,
                                children: [
                                  AppText(
                                    controller: _.tConfirmarSenha,
                                    label: 'Confirmar senha',
                                    password: _.obscureTextRepetirSenha.value,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    onFieldSubmitted: (v) {
                                      _.onClickCadastrar();
                                      Get.focusScope.unfocus();
                                    },
                                    onChanged: (String value) {
                                      _.formKeySenha.currentState.validate();
                                    },
                                    validator: _.validateRepetirSenha,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 8),
                                    child: IconButton(
                                      icon: Icon(_.obscureTextRepetirSenha.value
                                          ? LineAwesomeIcons.eye
                                          : LineAwesomeIcons.eye_slash),
                                      onPressed: _.onPressedObscureRepetirSenha,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      AppButton(
                        'Cadastrar',
                        color: Colors.blue,
                        onPressed: () => _.onClickCadastrar(),
                        showProgress: false,
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              Obx(
                () => _.loading.value
                    ? Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                    : Container(),
              )
            ],
          ),
        );
      },
    );
  }
}
