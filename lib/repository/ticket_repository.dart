import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'repository.dart';
import 'dart:io';

class TicketRepository extends Repository {
  final Dio _dio = Dio();

  Future addTicket(
      {required String name,
      required String title,
      required String desc,
      required String date,
      required File image}) async {
    try {
      FormData formData = FormData.fromMap({
        'judul': title,
        'desc': desc,
        'date': date,
        'gambar':
            await MultipartFile.fromFile(image.path, filename: 'image.jpg')
      });

      Response response = await _dio.post(
          "https://client-server-firli.000webhostapp.com/addtickets.php",
          data: formData);
      log("Response add data :" + response.data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to add news');
      }
    } catch (error) {
      log("Error $error");
    }
  }
}
