import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_item.dart';

import '../providers/products.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).items;

    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3 / 4.5,
        crossAxisCount: 2,
        mainAxisSpacing: 25,
        crossAxisSpacing: 15,
      ),
      itemBuilder: (context, index) => ProductItem(
        products[index].id,
        products[index].name,
        products[index].price,
        products[index].imageUrl,
      ),
    );
  }
}
