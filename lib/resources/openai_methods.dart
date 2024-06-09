import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:instagram_flutter/utils/global_variables.dart';
import 'package:dio/dio.dart';

class OpenAI_Methods {
  final dio = Dio();

  Future<String> sendImageToGPT4Vision( 
      {required Uint8List file,
      int maxTokens = 50,
      String model = "gpt-4-vision-preview"}) async {
    final String base64Image = await encodeImage(file);
    try {
      final response = await dio.post(
        "$OPENAI_BASE_URL/chat/completions",
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $OPENAI_API_KEY',
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode({
          'model': model,
          'messages': [
            {
              'role': 'system',
              'content': 'You have to give concise and short answers'
            },
            {
              'role': 'user',
              'content': [
                {
                  'type': 'text',
                  'text':
                      'GPT, your task is to estimate the total carbohydrates in a meal. Analyze any image of food or meals I provide, and give a estimation of the carbs in the meal. Simply give me a json string with a breakdown of the carb estimation.',
                },
                {
                  'type': 'image_url',
                  'image_url': {
                    'url': 'data:image/jpeg;base64,$base64Image',
                  },
                },
              ],
            },
          ],
          'max_tokens': maxTokens,
        }),
      );

      final jsonResponse = response.data;
      print(jsonResponse);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }
      return jsonResponse["choices"][0]["message"]["content"];
    } catch (e) {
      throw Exception("error: $e");
    }
  }

  Future<String> encodeImage(Uint8List image) async {
    return base64Encode(image);
  }
}
