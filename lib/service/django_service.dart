import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_app/models/user.dart';

import '../utils/KUtils.dart';

class APIService{

  static Future<bool> apiInscription(User user) async {
    bool result = false;
    var client = http.Client();
    var response = await client.post(
      Uri.parse(Kutils.ENDPOINT_INSCRIPTION),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      Map<String,dynamic> map = jsonDecode(response.body);
      User u = User.fromJson(map);
      return await Kutils.saveStudentSession(u);
    }
    return result;
  }

  static Future<bool> apiConnexion(User user) async {
    bool result = false;
    var client = http.Client();

    var response = await client.post(
      Uri.parse(Kutils.ENDPOINT_CONNEXION),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200 ) {
      Map<String,dynamic> map = jsonDecode(response.body);
      User u = User.fromJson(map);
      return await Kutils.saveStudentSession(u);
    }
    return result;
  }

  static Future<bool> api_update_token_firebase(String token) async {
    var client = http.Client();

    var response = await client.post(
      Uri.parse(Kutils.ENDPOINT_UPDATE_TOKEN_FIREBASE),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'token':token
      }),
    );

    if (response.statusCode == 200 ) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> uploadImage(File imageFile, int id) async {
    final url = Uri.parse(Kutils.ENDPOINT_ADD_IMAGE);
    final request = http.MultipartRequest('POST', url);

    // Ajoutez le fichier image
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
      ),
    );

    // Ajoutez les champs supplémentaires
    request.fields['id'] = "$id";

    try {
      final response = await request.send();
      if (response.statusCode == 201) {
        print("Image uploadée avec succès !");
        final responseBody = await response.stream.bytesToString();
        print("Réponse : $responseBody");
      } else {
        print("Erreur lors de l'envoi : ${response.statusCode}");
      }
    } catch (e) {
      print("Erreur : $e");
    }
  }
}