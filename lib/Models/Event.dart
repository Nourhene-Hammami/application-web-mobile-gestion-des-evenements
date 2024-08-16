class Event {
 final int id;
  late final String name;
  late final String lieu;
 late final  DateTime date;
  late final String desp;
    late final String organizateur;
 late final double priceForStudent;
  late final double priceForNoStudent;
  late final String city;
  final String filenameimg;
  late final int stoke;
  String? ticketType;
 int qte;
  double total=0;
 Event({
  required this.ticketType,  required this.qte, 
  required  this.id,
  required  this.name,
  required  this.lieu,
  required  this.date,
 required   this.desp,
  required   this.organizateur,
   required this.priceForStudent,
      required this.priceForNoStudent,
    required this.city,
   required this.filenameimg,
 required   this.stoke,
 this.total=0,
  }) ; 



  factory Event.fromJson(Map<String, dynamic> json) {
     if (json == null) {
     print('null json');
  }
  return Event(
      id: json['id']  ,
      name: json['name'],
      lieu: json['lieu'],
     // date: DateTime.parse(json['date']),
          date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),

      desp: json['desp'],
      organizateur: json['organizateur'],
      priceForStudent: json['priceForStudent'],
      priceForNoStudent: json['priceForNoStudent'],
      city: json['city'],
       ticketType: json['ticketType'],
        qte: json['qte'],
        total: json['total'],
      filenameimg: json['filenameimg'],
      stoke: json['stoke'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lieu': lieu,
      'date': date.toIso8601String(),
      'desp': desp,
      'organizateur': organizateur,
      'priceForStudent': priceForStudent,
         'priceForNoStudent': priceForNoStudent,
  //    'qte': qte,
           'ticketType': ticketType,

      'city': city,
    'total': total,
      'filenameimg': filenameimg,
      'stoke': stoke,
    };
  }


    dynamic operator[](String key) {
    switch (key) {
      case 'id':
        return id;
      case 'name':
        return name;
      case 'lieu':
        return lieu;
      case 'date':
        return date;
      case 'desp':
        return desp;
          case 'organizateur':
        return organizateur;
      case 'priceForStudent':
        return priceForStudent;
          case 'priceForNoStudent':
        return priceForNoStudent;
      case 'city': return city;
      case 'filenameimg':
        return filenameimg;
      case 'stoke':
        return stoke;
      default:
        throw ArgumentError('Invalid key: $key');
    }
  }
}
