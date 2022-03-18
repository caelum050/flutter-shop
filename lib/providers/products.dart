import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../providers/product.dart';

class Products with ChangeNotifier {
  final String authToken;
  Products(this.authToken, this._items);
  List<Product> _items = [];
  List<String> _brands = [];

  List<Product> get items {
    return [..._items];
  }

  List<String> get brands {
    return [..._brands];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchandSetProducts() async {
    final url =
        'https://skate-skies-default-rtdb.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      print(extractedData);
      final List<Product> loadedProducts = [];
      final List<String> loadedBrands = [];
      extractedData.forEach((prodId, prodData) {
        loadedBrands.add(prodData['brand']);
        loadedProducts.add(Product(
            id: prodId,
            name: prodData['name'],
            brand: prodData['brand'],
            category: prodData['category'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl']));
      });
      _items = loadedProducts;

      _brands = loadedBrands.toSet().toList();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchMpos() async {
    final response = await http.post(Uri.parse('https://killzone.mposglobal.com/MobileEngine/v1/and/Login'),
    headers: {HttpHeaders.authorizationHeader: "l4v0NR1bVulfNp0IgE3Atifbagvr9q0s"},
    body: jsonEncode(<String, String>{"isFirstRun":"true","user":"elima","password":"Noctis050.","userDevice":"{\"screenSizeWidthPx\":0,\"hasNFC\":false,\"hasFingerPrint\":true,\"ios\":\"iOS 14.4.2\",\"screenSizeHeightDp\":0,\"networkType\":\"CTRadioAccessTechnologyLTE\",\"codeName\":\"iPhone8\",\"operatingSystemVersion\":\"Android-iOS 14.4.2\",\"screenSizeHeightPx\":0,\"deviceName\":\"iPhone8\",\"connectedByNetwork\":false,\"manufacturer\":\"Apple Inc.\",\"connectedByWifi\":false,\"operator\":\"TIGO\",\"deviceHash\":\"-\",\"appVersion\":\"4.46\",\"model\":\"iPhone\",\"name\":\"iPhone8\",\"screenSizeWidthDp\":0}"}),
    );
    final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
    
    print(responseJson);
  }

  Future<void> fetchProductsByBrand(String brandName) async {
    final url =
        'https://skate-skies-default-rtdb.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Product> loadedProducts = [];
      final List<String> loadedBrands = [];
      extractedData.forEach((prodId, prodData) {
        loadedBrands.add(prodData['brand']);
        loadedProducts.add(Product(
            id: prodId,
            name: prodData['name'],
            brand: prodData['brand'],
            category: prodData['category'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl']));
      });
      if (brandName == '') {
        _items = loadedProducts;
      } else {
        _items =
            loadedProducts.where((prod) => prod.brand == brandName).toList();
      }

      _brands = loadedBrands.toSet().toList();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchProductsByCategory(String category) async {
    final url =
        'https://skate-skies-default-rtdb.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedBrandProducts = [];
      extractedData.forEach((key, value) {
        loadedBrandProducts.add(Product(
            id: key,
            name: value['name'],
            brand: value['brand'],
            category: value['category'],
            description: value['description'],
            price: value['price'],
            imageUrl: value['imageUrl']));
      });
      _items = loadedBrandProducts
          .where((prod) => prod.category == category)
          .toList();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProducts(Product product) async {
    final url =
        'https://skate-skies-default-rtdb.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': product.name,
          'brand': product.brand,
          'category': product.category,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl
        }),
      );
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          name: product.name,
          brand: product.brand,
          category: product.category,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://skate-skies-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
      try {
        await http.patch(url,
            body: json.encode({
              'name': newProduct.name,
              'brand': newProduct.brand,
              'category': newProduct.category,
              'description': newProduct.description,
              'price': newProduct.price,
              'imageUrl': newProduct.imageUrl
            }));
        _items[prodIndex] = newProduct;
        notifyListeners();
      } catch (error) {
        throw (error);
      }
    } else {}
  }

  void deleteProduct(String id) {
    final url =
        'https://skate-skies-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeWhere((prod) => prod.id == id);
    try {
      http.delete(url);
      existingProduct = null;
      notifyListeners();
    } catch (error) {
      _items.insert(existingProductIndex, existingProduct);
      throw (error);
    }
  }
}
