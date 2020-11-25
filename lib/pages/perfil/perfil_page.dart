import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:jukebox_teste/pages/login/login_page.dart';
import 'package:jukebox_teste/pages/perfil/editar_perfil_bottom_sheet.dart';
import 'package:jukebox_teste/pages/perfil/usuario_api.dart';
import 'package:jukebox_teste/pages/perfil/usuario_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukebox_teste/utils/api_response.dart';
import 'package:jukebox_teste/utils/date_utils.dart';
import 'package:jukebox_teste/utils/prefs.dart';
import 'package:jukebox_teste/widgets/app_card.dart';
import 'package:jukebox_teste/widgets/app_dialog.dart';
import 'package:jukebox_teste/widgets/app_hash_dialog.dart';
import 'package:jukebox_teste/widgets/tile.dart';

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsuarioController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Teste Jukebox'),
            actions: <Widget>[
              AppHashDialog(),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'Editar') {
                    EditarPerfilBottomSheet.show();
                  } else if (value == 'Excluir') {
                    _onClickExcluirConta(_);
                  } else if (value == 'Sair') {
                    _onClickSair(_);
                  }
                },
                icon: Icon(
                  LineAwesomeIcons.vertical_ellipsis,
                ),
                tooltip: 'Mais opções',
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'Editar',
                    child: Text('Editar perfil'),
                  ),
                  PopupMenuItem(
                    value: 'Excluir',
                    child: Text('Excluir conta'),
                  ),
                  PopupMenuItem(
                    value: 'Sair',
                    child: Text('Sair'),
                  ),
                ],
              )
            ],
          ),
          body: _body(_),
        );
      },
    );
  }

  _body(UsuarioController _) {
    return RefreshIndicator(
      onRefresh: () => _.onRefresh(),
      child: ListView(
        children: [
          SizedBox(height: 2),
          _cardInformacoesPessoais(_),
          SizedBox(height: 2)
        ],
      ),
    );
  }

  Container _cardInformacoesPessoais(UsuarioController _) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: AppCard(
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Tile(
                  title: TitleTile(
                    'Informações pessoais',
                    bold: true,
                  ),
                ),
                Tile(
                  leading: Icon(
                    LineAwesomeIcons.user,
                  ),
                  title: TitleTile(
                    '${_.usuario.nome}',
                  ),
                  subtitle: 'Nome',
                ),
                Tile(
                    leading: Icon(
                      LineAwesomeIcons.at,
                    ),
                    title: TitleTile(
                      _.usuario.email,
                    ),
                    subtitle: 'E-mail'),
                Tile(
                    leading: Icon(
                      LineAwesomeIcons.calendar,
                    ),
                    title: TitleTile(DateUtil.format(_.usuario.dataNascimento)),
                    subtitle: 'Data de nascimento'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onClickSair(UsuarioController _) {
    AppDialog(
      Text('Deseja realmente sair?'),
      onCancel: () => Get.back(),
      textConfirm: 'Sair',
      textCancel: 'Cancelar',
      confirmColor: Colors.red,
      onConfirm: () {
        Prefs.setString('lastLogin', _.usuario.email);
        _.clear();
        Get.back();
        Get.off(
          LoginPage(),
        );
      },
    ).show();
  }

  void _onClickExcluirConta(UsuarioController _) {
    AppDialog(
      Text('Deseja realmente exluir a conta?'),
      onCancel: () => Get.back(),
      textConfirm: 'Excluir',
      textCancel: 'Cancelar',
      confirmColor: Colors.red,
      onConfirm: () async {
        ApiResponse<bool> response =
            await UsuarioApi.deletar(UsuarioController.to.usuario.id);
        if (response.ok) {
          Prefs.setString('lastLogin', '');
          _.clear();
          Get.back();
          Get.off(
            LoginPage(),
          );
          AppDialog(Text('Conta excluída com sucesso.'),
              textConfirm: 'Ok', onConfirm: () => Get.back()).show();
        }
      },
    ).show();
  }
}
