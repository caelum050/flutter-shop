import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BrandItem {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  BrandItem({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.imageUrl,
  });
}

class Brand with ChangeNotifier {
  final String authToken;
  Brand(this.authToken, this._brands);
  List<BrandItem> _brands = [];

  List<BrandItem> get brands {
    return [..._brands];
  }

  BrandItem findById(String id) {
    return _brands.firstWhere((brand) => brand.id == id);
  }

  Future<void> fecthandSetBrands() async {
    final url =
        'https://skate-skies-default-rtdb.firebaseio.com/brands.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<BrandItem> loadedBrands = [];
      extractedData.forEach((key, value) {
        loadedBrands.add(BrandItem(
            id: key,
            name: value['name'],
            description: value['description'],
            imageUrl: value['imageUrl']));
      });
      _brands = loadedBrands;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addBrand(BrandItem brand) async {
    final url =
        'https://skate-skies-default-rtdb.firebaseio.com/brands.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': brand.name,
          'description': brand.description,
          'imageUrl': brand.imageUrl
        }),
      );
      final newBrand = BrandItem(
          id: json.decode(response.body)['name'],
          name: brand.name,
          description: brand.description,
          imageUrl: brand.imageUrl);
      _brands.add(newBrand);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateBrand(String id, BrandItem newBrand) async {
    final brandIndex = _brands.indexWhere((br) => br.id == id);
    if (brandIndex >= 0) {
      final url =
          'https://skate-skies-default-rtdb.firebaseio.com/brands/$id.json?auth=$authToken';
      try {
        await http.patch(url,
            body: json.encode({
              'name': newBrand.name,
              'description': newBrand.description,
              'imageUrl': newBrand.imageUrl
            }));
        _brands[brandIndex] = newBrand;
        notifyListeners();
      } catch (error) {
        throw (error);
      }
    }
  }

  void deleteBrand(String id) {
    final url =
        'https://skate-skies-default-rtdb.firebaseio.com/brands/$id.json?auth=$authToken';
    final existingBrandIndex = _brands.indexWhere((br) => br.id == id);
    var existingBrand = _brands[existingBrandIndex];
    _brands.removeWhere((br) => br.id == id);
    try {
      http.delete(url);
      existingBrand = null;
      notifyListeners();
    } catch (error) {
      _brands.insert(existingBrandIndex, existingBrand);
      throw (error);
    }
  }
}
