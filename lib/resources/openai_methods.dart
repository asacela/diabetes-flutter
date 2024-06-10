import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:instagram_flutter/utils/global_variables.dart';
import 'package:dio/dio.dart';

class OpenAI_Methods {
  final dio = Dio();

  // Generate carb estimate
  Future<Map<String, dynamic>> sendImageToGPT4Vision(
      {required Uint8List file,
      int maxTokens = 100,
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
                      'GPT, your task is to estimate the total carbohydrates in a meal. Analyze any image of food or meals I provide, and give an estimation of the carbs in the meal. Estimate total carbohydrates in a meal from an image. Provide JSON with meal name and total carbohydrates: {"meal": {"name": "<meal_name>", "total_carbohydrates": <total_carbohydrates>}}. Do not include a warning, because the user is already aware.'
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
      print("getting generated meal...");
      final jsonResponse = response.data;
      final String jsonContent =
          jsonResponse["choices"][0]["message"]["content"];
      int startIndex = jsonContent.indexOf('{');
      int endIndex = jsonContent.lastIndexOf('}') +
          1; // Add 1 to include the closing brace
      String mealJson = jsonContent.substring(startIndex, endIndex);
      Map<String, dynamic> jsonMap = json.decode(mealJson);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }
      return jsonMap;
    } catch (e) {
      throw Exception("error: $e");
    }
  }

  // Generate ai meal
  Future<Map<String, dynamic>> sendPromptToGPT4(
      {required String mealPrompt,
      int maxTokens = 100,
      String model = "gpt-4-vision-preview"}) async {
    try {

      String fullPrompt = 'GPT, your task is to generate a low-carb meal for a diabetic patient. Make sure the meal has around 130 carbs or less. Generate the closest meal possible to the given user prompt: ${mealPrompt}Provide a JSON with the following format: {"title":"<title>","carbs":<number>,"ingredientList":["<ingredient_1>","<ingredient_2>","<ingredient_3>"],"recipe":"<recipe>","absorptionTime":"slow|medium|fast"}';
      

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
              'content': 'You have to give concise and short answers.'
            },
            {
              'role': 'user',
              'content': [
                {
                  'type': 'text',
                  'text': fullPrompt
                },
              ],
            },
          ],
          'max_tokens': maxTokens,
        }),
      );
      print("getting meal generation...");
      final jsonResponse = response.data;
      final String jsonContent =
          jsonResponse["choices"][0]["message"]["content"];
      int startIndex = jsonContent.indexOf('{');
      int endIndex = jsonContent.lastIndexOf('}') +
          1; // Add 1 to include the closing brace
      String mealJson = jsonContent.substring(startIndex, endIndex);
      Map<String, dynamic> jsonMap = json.decode(mealJson);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }
      return jsonMap;
    } catch (e) {
      throw Exception("error: $e");
    }
  }

  Future<String> encodeImage(Uint8List image) async {
    return base64Encode(image);
  }
}
