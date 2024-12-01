class User {

  int? id = 0;
  String? nom = "";
  String? prenom = "";
  String numero;
  String? password = "";

  User({this.id, this.nom, this.prenom, required this.numero, this.password});

  Map<String, dynamic> toJson(){
    return {
      'id':this.id,
      'nom':this.nom,
      'prenom':this.prenom,
      'numero':this.numero,
      'password':this.password
    };
  }

  static User fromJson(Map<String, dynamic> map){
    return User(id: map['id'], nom: map['nom'], prenom: map['prenom'], numero: map['numero'], password: '');
  }

  @override
  String toString() {
    return "$id $nom $prenom $numero";
  }
}