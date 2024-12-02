class User {
  // Attributs de l'utilisateur
  final int id; // Identifiant unique
  final String nom;
  final String prenom;
  final String telephone;
  final String password;

  // Constructeur
  User({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.telephone,
    required this.password,
  });

  // Méthode pour convertir l'objet User en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'telephone': telephone,
      'password': password,
    };
  }

  // Méthode pour créer un objet User à partir d'un JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      telephone: json['telephone'],
      password: json['password'],
    );
  }

  // Méthode utilitaire pour afficher les informations de l'utilisateur
  @override
  String toString() {
    return 'User{id: $id, nom: $nom, prenom: $prenom, telephone: $telephone}';
  }
}
