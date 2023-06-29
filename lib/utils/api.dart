import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  Api({required this.host, required this.scheme, this.port = 443});
  final String host;
  final String scheme;
  final int port;

  final headers = {'Content-Type': 'application/json'};

  Future postRequest(String path, Map<String, String> data) async {
    Uri url = getUri(path);
    http.Response response =
        await http.post(url, body: jsonEncode(data), headers: headers);
    return response;
  }

  Uri getUri(String path) {
    Uri url = Uri(host: host, scheme: scheme, path: path, port: port);
    return url;
  }

  decodeResponse(response) {
    Map<String, dynamic> decodeData = {};
    String data = response.body;
    try {
      decodeData = jsonDecode(data);
    } catch (err) {
      print(err);
    }
    return decodeData;
  }

  sendLoginData(Map<String, String> data, context) async {
    http.Response res = await postRequest('/api/test/contact/', data);
    String msg = 'bad request';

    if (res.statusCode == 201) {
      msg = 'request success';
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Center(
        child: Text(
          msg,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      )),
    );
    return res;
  }
}

Api api = Api(host: 'api.byteplex.info', scheme: 'https');
