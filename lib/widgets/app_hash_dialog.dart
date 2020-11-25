import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukebox_teste/pages/perfil/usuario_controller.dart';
import 'package:jukebox_teste/utils/prefs.dart';
import 'package:jukebox_teste/utils/singleton.dart';
import 'package:jukebox_teste/widgets/app_dialog.dart';
import 'package:jukebox_teste/widgets/app_text.dart';

class AppHashDialog extends StatelessWidget {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        AppDialog(
          Column(
            children: [
              Text('HASH atual: ${Factory.hash ?? ''}'),
              SizedBox(
                height: 8,
              ),
              AppText(
                label: 'Novo HASH',
                controller: _controller,
              ),
            ],
          ),
          textConfirm: 'Salvar',
          textCancel: 'Cancelar',
          onConfirm: () {
            Factory.hash = _controller.text;
            Prefs.setString('hash', _controller.text);
            Get.back();
            UsuarioController.to.getUsuario();
          },
        ).show();
      },
      child: Text(
        'ATUALIZAR HASH',
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.blue,
    );
  }
}
