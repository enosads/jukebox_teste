import 'package:jukebox_teste/utils/prefs.dart';

class Factory {
  static final Factory _instance = Factory.internal();

  factory Factory() => _instance;

  Factory.internal();

  static String hash = '';

  static Future<String> getHash() async {
    hash = await Prefs.getString('hash');
    return hash;
  }

  final String url = 'https://crudcrud.com/api';

  Future<String> getUrl() async {
    String hash = await Prefs.getString('hash');
    return '$url/$hash/';
  }
}
