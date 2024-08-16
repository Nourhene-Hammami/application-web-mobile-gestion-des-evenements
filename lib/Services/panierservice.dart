import 'package:eventmobile/Models/Lpanier.dart';
import 'package:eventmobile/Models/Panier.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class PanierService {


  final String baseUrl = "http://10.0.2.2:9000/lpanier";

  Future<int?> saveOrUpdate(Panier panier) async {
    final response = await http.post(Uri.parse("http://10.0.2.2:9000/paniers"),
   
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(panier.toJson()));
         print(' response= $panier');
           print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
        final id= jsonResponse ;
   print(jsonResponse);
         return    id ;
      
 
    } else {
      throw Exception('Failed to save or update panier.');
    }
  }

  Future<Lpanier> addToLpanier(Lpanier lpanier, int panierId, int userId) async {
    final response = await http.post(Uri.parse('$baseUrl/$panierId/$userId'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(lpanier.toJson()));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return Lpanier.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to add to lpanier.');
    }
  }
}