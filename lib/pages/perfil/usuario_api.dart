import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:jukebox_teste/models/usuario_model.dart';
import 'package:jukebox_teste/utils/api_response.dart';
import 'package:jukebox_teste/utils/http_helper.dart' as http;
import 'package:jukebox_teste/utils/singleton.dart';

class UsuarioApi {
  static Future<ApiResponse<Usuario>> login(String email, String senha) async {
    try {
      if (Factory.getHash() != null) {
        var url = await Factory.internal().getUrl() + 'usuario/';

        var response = await http.get(
          url,
        );
        print('GET >> $url  Status: ${response.statusCode}');

        if (response.statusCode == 200) {
          List<Usuario> usuarios = response.data
              .map<Usuario>((map) => Usuario.fromMap(map))
              .toList();
          Usuario usuarioEncontrado;
          usuarios.forEach((usuario) {
            if (usuario.email == email &&
                usuario.senha == md5.convert(utf8.encode(senha)).toString()) {
              usuarioEncontrado = usuario;
            }
          });
          if (usuarioEncontrado != null) {
            return ApiResponse.ok(result: usuarioEncontrado);
          } else {
            return ApiResponse.error(msg: 'Email ou senha inválidos');
          }
        } else {
          return ApiResponse.error(msg: 'Email ou senha inválidos');
        }
      } else {
        return ApiResponse.error(msg: 'O HASH não foi inserido.');
      }
    } catch (error, exception) {
      print('Erro no login: $error > $exception');
      return ApiResponse.error(msg: 'Não foi possível fazer o login');
    }
  }

  static Future<ApiResponse<Usuario>> verificarEmailCadastrado(
      String email) async {
    try {
      if (Factory.getHash() != null) {
        var url = await Factory.internal().getUrl() + 'usuario/';

        var response = await http.get(
          url,
        );
        print('GET >> $url  Status: ${response.statusCode}');

        if (response.statusCode == 200) {
          List<Usuario> usuarios = response.data
              .map<Usuario>((map) => Usuario.fromMap(map))
              .toList();
          Usuario encontrado;

          usuarios.forEach((usuario) {
            if (usuario.email == email) {
              encontrado = usuario;
            }
          });
          return ApiResponse.ok(result: encontrado);
        } else {
          return ApiResponse.error(msg: 'Erro ao verificar email');
        }
      }
    } catch (error, exception) {
      print('Erro no login: $error > $exception');
      return ApiResponse.error(msg: 'Erro ao verificar email');
    }
  }

  static Future<ApiResponse<Usuario>> loginId(String id) async {
    try {
      if (Factory.getHash() != null) {
        var url = await Factory.internal().getUrl() + 'usuario/$id';
        print(url);
        var response = await http.get(
          url,
        );
        print('here');
        print('GET >> $url  Status: ${response.statusCode}');

        if (response.statusCode == 200) {
          final user = Usuario.fromMap(response.data);

          return ApiResponse.ok(result: user);
        }
        return ApiResponse.error(msg: 'Não foi possível logar');
      } else {
        return ApiResponse.error(msg: 'O HASH não foi inserido.');
      }
    } catch (error, exception) {
      print('Erro no login: $error > $exception');
      return ApiResponse.error(msg: 'Não foi possível fazer o login');
    }
  }

  static Future<ApiResponse<bool>> deletar(String id) async {
    try {
      var url = await await Factory.internal().getUrl() + 'usuario/$id';

      var response = await http.delete(
        url,
      );
      print('DELETE >> $url  Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        return ApiResponse.ok(result: true);
      }
      return ApiResponse.error(
          msg: 'Não foi possível deletar o usuário', result: false);
    } catch (error, exception) {
      print('Erro no login: $error > $exception');
      return ApiResponse.error(msg: 'Não foi possível deletar o usuário');
    }
  }

  static Future<ApiResponse<bool>> update(String id, String nome, String email,
      String senha, String dataNascimento) async {
    try {
      var url = await Factory.internal().getUrl() + 'usuario/$id';

      final Map params = {
        "nome": nome,
        "email": email,
        "data_nascimento": dataNascimento,
        "senha": md5.convert(utf8.encode(senha)).toString()
      };

      var response = await http.put(url, body: params);
      print('PUT >> $url  Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        return ApiResponse.ok(result: true);
      } else {
        return ApiResponse.error(
            msg: 'Algumas campos possuem erros.', result: false);
      }
    } catch (error, exception) {
      print('Erro ao editar perfil: $error > $exception');
      return ApiResponse.error(msg: 'Não foi possível atualizar o perfil');
    }
  }

  static Future<ApiResponse<bool>> cadastrar(
      String nome, String email, String senha, String dataNascimento) async {
    try {
      var url = await Factory.internal().getUrl() + 'usuario/';
      print(url);

      final Map params = {
        "nome": nome,
        "email": email,
        "data_nascimento": dataNascimento,
        "senha": md5.convert(utf8.encode(senha)).toString()
      };

      String s = json.encode(params);
      print(s);
      var response = await http.post(url, body: s);
      print('POST >> $url  Status: ${response.statusCode}');
      print(response.data);
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return ApiResponse.ok();
      } else {
        return ApiResponse.error(
            msg: 'Não foi possível cadastrar o usuário.', result: false);
      }
    } catch (error, exception) {
      print('Erro ao cadastrar usuario: $error > $exception');
      return ApiResponse.error(msg: 'Não foi possível efetuar o cadastro');
    }
  }
}
