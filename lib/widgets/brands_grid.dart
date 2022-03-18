import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/brand_item.dart';

import '../providers/brands.dart';

class BrandsGrid extends StatelessWidget {
  const BrandsGrid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brands = Provider.of<Brand>(context).brands;
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: brands.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3 / 4,
          crossAxisCount: 2,
          mainAxisSpacing: 25,
          crossAxisSpacing: 15),
      itemBuilder: (context, index) => BrandItemView(
        brands[index].id,
        brands[index].name,
        brands[index].imageUrl,
      ),
    );
  }
}
