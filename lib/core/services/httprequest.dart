import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../controller/myuser_controller.dart';
import '../constant/data.dart';

Future<(http.Response?, bool)> httpRequest({required String ftpFile, Map<String, String> json = const {}}) async {
  MyUserController userController = Get.find();
  // Avoid modifying the original JSON map
  final requestBody = {
    ...json,
    if (!json.containsKey("BDD")) "BDD": AppData.dossier,
    "ID_POSTE": AppData.idPoste,
    'ID_USER': userController.idUser.toString(),
  };

  // Cache the server directory to avoid repeated calls
  final serverDir = AppData.getServerDirectory();
  final url = "$serverDir/$ftpFile";

  if (kDebugMode) {
    debugPrint("Request URL: $url");
    debugPrint("Request requestBody: $requestBody");
  }

  try {
    // Await the HTTP POST request and handle the response
    final response = await http.post(Uri.parse(url), body: requestBody).timeout(AppData.getTimeOut());

    // Check the status code and return the appropriate tuple
    if (response.statusCode == 200) {
      return (response, true);
    } else {
      if (kDebugMode) {
        debugPrint("HTTP request failed on file $ftpFile  ,statusCode = ${response.statusCode} ");
      }

      return (response, false);
    }
  } catch (error) {
    if (kDebugMode) {
      debugPrint("HTTP request failed on file $ftpFile : $error");
    }
    return (null, false);
  }
}
