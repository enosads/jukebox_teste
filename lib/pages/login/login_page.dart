import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:jukebox_teste/pages/login/login_page_controller.dart';
import 'package:jukebox_teste/pages/recuperar_senha/recuperar_senha_page.dart';
import 'package:jukebox_teste/pages/recuperar_senha/recuperar_senha_page_controller.dart';
import 'package:jukebox_teste/widgets/app_button.dart';
import 'package:jukebox_teste/widgets/app_hash_dialog.dart';
import 'package:jukebox_teste/widgets/app_text.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginPageController(),
      builder: (LoginPageController _) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.topRight,
            children: <Widget>[
              Form(
                key: _.formKey,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 24.0, right: 24.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 24.0),
                          Hero(
                            tag: 'hero',
                            child: CircleAvatar(
                              radius: 120.0,
                              child: Icon(
                                LineAwesomeIcons.user,
                                size: 120,
                              ),
                            ),
                          ),
                          SizedBox(height: 24.0),
                          AppText(
                            hint: 'Email',
                            controller: _.tEmail,
                            validator: _.validateEmail,
                            nextFocus: _.focusSenha,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 16.0),
                          Obx(
                            () => Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                AppText(
                                  hint: 'Senha',
                                  controller: _.tSenha,
                                  password: _.obscureTextSenha.value,
                                  validator: _.validateSenha,
                                  focusNode: _.focusSenha,
                                  onFieldSubmitted: (next) => _.onClickLogin(),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 8),
                                  child: IconButton(
                                    icon: Icon(_.obscureTextSenha.value
                                        ? LineAwesomeIcons.eye_slash
                                        : LineAwesomeIcons.eye),
                                    onPressed: _.onPressedObscureSenha,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 24.0),
                          Row(
                            children: [
                              Expanded(
                                child: AppButton(
                                  'Entrar',
                                  onPressed: () => _.onClickLogin(),
                                  showProgress: false,
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  expanded: false,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: AppButton(
                                  'Cadastrar',
                                  onPressed: () => _.onClickCadastrar(),
                                  showProgress: false,
                                  expanded: false,
                                ),
                              ),
                            ],
                          ),
                          FlatButton(
                              onPressed: () => Get.to(RecuperarSenhaPage()),
                              child: Text('Recuperar senha')),
                          SizedBox(height: 16.0),
                          SizedBox(height: 24.0),
                        ],
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
                  AppHashDialog(),
                ],
              ),
              Obx(() => _.loading.value
                  ? Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  : Container())
            ],
          ),
        );
      },
    );
  }
}
