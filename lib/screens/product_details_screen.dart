import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/badge.dart';

import '../screens/cart_screen.dart';

import '../providers/products.dart';
import '../providers/cart.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context).findById(productId);
    final cart = Provider.of<Cart>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text(loadedProduct.name),
          actions: [
            Consumer<Cart>(
              builder: (_, cartData, ch) => Badge(
                child: ch,
                value: cartData.itemCount.toString(),
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              Text(loadedProduct.name, style: TextStyle(fontSize: 15)),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text('\$${loadedProduct.price}'),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () {
                    cart.addItem(loadedProduct.id, loadedProduct.price,
                        loadedProduct.name);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Added item to cart!'),
                      duration: Duration(seconds: 3),
                    ));
                  },
                  child: Text('Add to Cart'),
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      onPrimary: Colors.white)),
              SizedBox(
                height: 25,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: double.infinity,
                child: Text(
                  loadedProduct.description,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ));
  }
}
