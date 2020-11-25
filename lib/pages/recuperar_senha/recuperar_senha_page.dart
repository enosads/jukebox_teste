import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukebox_teste/pages/recuperar_senha/recuperar_senha_page_controller.dart';
import 'package:jukebox_teste/widgets/app_button.dart';
import 'package:jukebox_teste/widgets/app_hash_dialog.dart';
import 'package:jukebox_teste/widgets/app_text.dart';

class RecuperarSenhaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: RecuperarSenhaPageController(),
      builder: (RecuperarSenhaPageController _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Recuperar senha'),
            actions: [AppHashDialog()],
          ),
          body: _body(_),
        );
      },
    );
  }

  _body(RecuperarSenhaPageController _) {
    return Form(
      key: _.formKey,
      child: ListView(
        children: [
          Center(
            child: AppText(
              controller: _.tEmail,
              label: 'E-mail',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              validator: _.validateEmail,
            ),
          ),
          SizedBox(height: 8,),
          AppButton('Enviar email', expanded: false, onPressed: ()=>_.onClickEnviarEmail(),)

        ],
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      ),
    );
  }
}
