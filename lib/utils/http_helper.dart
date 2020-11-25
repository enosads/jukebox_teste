import 'package:dio/dio.dart';

Future<Response> get(String url) async {
  final headers = await _headers();
  var response = await Dio().get(url, options: Options(headers: headers));
  return response;
}

Future<Response> post(String url, {body, headers}) async {
  final h = headers ?? await _headers();
  var response =
      await Dio().post(url, data: body, options: Options(headers: h));
  return response;
}

Future<Response> put(String url, {body}) async {
  final headers = await _headers();
  var response = await Dio().put(url,
      options: Options(
        headers: headers,
      ),
      data: body);
  return response;
}

Future<Response> patch(String url, {body}) async {
  final headers = await _headers();
  var response = await Dio().patch(url,
      options: Options(
        headers: headers,
      ),
      data: body);
  return response;
}

Future<Response> delete(String url) async {
  final headers = await _headers();
  var response = await Dio().delete(
    url,
    options: Options(
      headers: headers,
    ),
  );
  return response;
}

Future<Map<String, String>> _headers() async {
  Map<String, String> headers = {
    "Content-Type": "application/json",
  };
  return headers;
}
