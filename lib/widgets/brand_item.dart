import 'package:flutter/material.dart';

import '../screens/products_by_brand_screen.dart';

class BrandItemView extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;

  BrandItemView(this.id, this.name, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductsByBrandScreen.routeName, arguments: name);
        },
        child: GridTile(
          child: Image.network(imageUrl),
          footer: GridTileBar(
            title: Text(
              name,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.black54,
          ),
        ),
      ),
    );
  }
}
