import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:organibot/api/urls.dart';
import 'package:organibot/models/ai_bot_model.dart';

final class APIHelper {
  final Dio _dio;
  APIHelper() : _dio = Dio();
  Future<OrganiBotResponseModel> sendMessageAPI({required String msg}) async {
    try {
      Response response = await _dio.post(
        Urls.baseUrl,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          "contents": [
            {
              "parts": [
                {"text": msg},
              ],
            },
          ],
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return OrganiBotResponseModel.fromJson(response.data);
      } else {
        debugPrint("Failed with status: ${response.statusCode}");
        throw Exception("API returned status: ${response.statusCode}");
      }
    } on DioException catch (e) {
      debugPrint("DioException: ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      debugPrint("Unknown exception: $e");
      throw Exception(e.toString());
    }
  }
}