class Panier {
  int id;
  String nom;
  String adresse;
  String ville;
int tel;
 String codep;

  Panier({required  this.id,required  this.nom, required this.adresse,required  this.ville, required this.tel, required  this.codep});

  Map<String, dynamic> toJson() => {
        'id': id,
        'nom': nom,
        'adresse': adresse,
        'ville': ville,
        'tel': tel,
        'codep': codep,
      };
}