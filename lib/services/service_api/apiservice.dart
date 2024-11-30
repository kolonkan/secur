import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_app/models/users.dart';

class ApiService {
  // URL de base de l'API
  static const String baseUrl =
      "http://192.168.1.133:8000/sguser/add_user"; // Remplacez par votre URL

  // Méthode pour inscrire un utilisateur
  Future<bool> signup(User user) async {
    final url = Uri.parse('$baseUrl');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()), // Convertir l'objet User en JSON
      );

      if (response.statusCode == 200) {
        return true; // Succès
      } else {
        return false; // Échec
      }
    } catch (e) {
      // print("Exception lors de l'inscription : $e");
      return false;
    }
  }

  // Méthode pour connecter un utilisateur
  Future<bool> login(String telephone, String password) async {
    final url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'telephone': telephone, 'password': password}),
      );

      if (response.statusCode == 200) {
        print("Connexion réussie : ${response.body}");
        return true; // Succès
      } else {
        print("Erreur lors de la connexion : ${response.body}");
        return false; // Échec
      }
    } catch (e) {
      print("Exception lors de la connexion : $e");
      return false;
    }
  }

  // Méthode pour récupérer les informations d'un utilisateur par ID
  Future<User?> fetchUser(int id) async {
    final url = Uri.parse('$baseUrl/users/$id');

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return User.fromJson(data); // Créer un objet User à partir des données
      } else {
        print(
            "Erreur lors de la récupération de l'utilisateur : ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception lors de la récupération de l'utilisateur : $e");
      return null;
    }
  }
}
