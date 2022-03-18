import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_details_screen.dart';

import '../providers/cart.dart';
//import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  ProductItem(this.id, this.name, this.price, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    //final product = Provider.of<Product>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetailsScreen.routeName, arguments: id);
        },
        child: GridTile(
          child: Image.network(imageUrl),
          header: GridTileBar(
            title: Text(
              name,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.black54,
          ),
          footer: GridTileBar(
            title: Text(
              '\$${price.toString()}',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.black54,
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Theme.of(context).accentColor,
              onPressed: () {
                cart.addItem(id, price, name);
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Added item to cart!'),
                  duration: Duration(seconds: 3),
                ));
              },
            ),
          ),
        ),
      ),
    );
  }
}
