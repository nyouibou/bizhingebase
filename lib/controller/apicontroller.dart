import 'package:http/http.dart' as http;
import 'dart:convert'; // Import this to handle JSON decoding
import '../model/catmodelresp.dart'; // Your CatModelApiResp class

class ApiService {
  static const String baseUrl = "https://apib2b-production.up.railway.app/api/";

  // This method now returns a Future<List<CatModelApiResp>> instead of a single object
  Future<List<CatModelApiResp>> fetchCategories() async {
    final response = await http.get(Uri.parse("${baseUrl}categories"));

    if (response.statusCode == 200) {
      // Parse the JSON response body into a list of CatModelApiResp
      return catModelApiRespFromJson(
          response.body); // This now returns a List<CatModelApiResp>
    } else {
      throw Exception("Failed to load categories");
    }
  }

  Future<List<Product>> fetchAllProducts() async {
    final response = await http.get(Uri.parse("${baseUrl}products"));

    if (response.statusCode == 200) {
      // Parse the JSON response body into a list of Product objects
      List<dynamic> data = json.decode(response.body);
      return List<Product>.from(data.map((x) => Product.fromJson(x)));
    } else {
      throw Exception("Failed to load products");
    }
  }
}
