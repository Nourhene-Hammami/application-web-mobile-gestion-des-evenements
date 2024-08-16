class Lpanier {
  int id;
  String libelle;
  double price;
  int qte;
  double total;
  String ticketType;
  int panierId;

  Lpanier(
      { required this.id,
  required     this.libelle,
  required     this.price,
   required    this.qte,
   required    this.total,
    required   this.ticketType,
   required    this.panierId});

  Map<String, dynamic> toJson() => {
        'id': id,
        'libelle': libelle,
        'price': price,
        'qte': qte,
        'total': total,
        'ticketType': ticketType,
        'panierId': panierId,
      };

      factory Lpanier.fromJson(Map<String, dynamic> json) {
    return Lpanier(
      libelle: json['libelle'],
      price: json['price'],
      qte: json['qte'],
      total: json['total'],
      ticketType: json['ticketType'],
      panierId: json['panierId'],
      id: json['id'], 
   
    );
  }
}