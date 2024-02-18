import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  Future<bool> checkSession(String sessionToken) async {
    final Dio dio = Dio();

    try {
      final Dio _dio = Dio();
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      final String session = preferences.getString('session') ?? "";
      Map fdataMap = {'session': session};
      FormData formData = FormData();
      formData.fields
          .addAll(fdataMap.entries.map((e) => MapEntry(e.key, e.value)));

      final response = await _dio.post(
          "https://client-server-firli.000webhostapp.com/session.php",
          data: formData);
      log("check session $response");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        preferences.setString('nama', data['hasil']['name']);
        return data['status'] == 'success';
      }
    } catch (error) {}
    return false;
  }
}
