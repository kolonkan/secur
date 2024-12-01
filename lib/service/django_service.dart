import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/models/user.dart';

import '../utils/KUtils.dart';

class APIService{

  static Future<bool> apiInscription(User user) async {
    var client = http.Client();

    var response = await client.post(
      Uri.parse(Kutils.ENDPOINT_INSCRIPTION),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      Kutils.saveStudentSession(user).
      then((value) {
        if( value ) return true;
        else{
          print("erreur : ");
          return false;
        }
      }).
      onError((error, stackTrace) {
        print("${stackTrace} ${error}");
       return false;
      });
    } else {
      return false;
    }
  }

  static Future<bool> apiConnexion(User user) async {
    var client = http.Client();

    var response = await client.post(
      Uri.parse(Kutils.ENDPOINT_CONNEXION),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );


    if (response.statusCode == 200 ) {
      Kutils.saveStudentSession(user).
      then((value) {
        if( value ) return true;
        else{
          print("erreur : ");
          return false;
        }
      }).
      onError((error, stackTrace) {
        print("${stackTrace} ${error}");
        return false;
      });
    }else{
        return false;
    }
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

}