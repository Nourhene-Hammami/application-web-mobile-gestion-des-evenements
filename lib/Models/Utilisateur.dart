class Utilisateur {


   late  final String mail;
  late final String password;
late  final String role ;
late   String name;
  late final int? id;

  Utilisateur( {required this.mail, required this.password, required this.role,required this.name, required this.id});


 
  Map<String, dynamic> toJson() => {
    'mail': mail,
    'password': password,
    'role': role,
    'name': name,
    'id':id,
  };



 factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      mail: json['mail'],
      password: json['password'],
      role: json['role'],
      name: json['name'], 
   id: json['id']
    );
  }
 
}