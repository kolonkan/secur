class User {

  int pk = 0;
  String? nom = "";
  String? prenom = "";
  String numero;
  String? password = "";

  User({this.pk, this.nom, this.prenom, required this.numero, this.password});

  Map<String, dynamic> toJson(){
    return {
      'pk':this.pk,
      'nom':this.nom,
      'prenom':this.prenom,
      'numero':this.numero,
      'password':this.password
    };
  }

  static User fromJson(Map<String, dynamic> map){
    return User(pk: map['pk'], nom: map['nom'], prenom: map['prenom'], numero: map['numero'], password: '');
  }

  @override
  String toString() {
    return "$pk $nom $prenom $numero";
  }
}