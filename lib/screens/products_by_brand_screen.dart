import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';

import '../providers/products.dart';

class ProductsByBrandScreen extends StatefulWidget {
  static const routeName = '/products-by-brand';

  @override
  _ProductsByBrandScreenState createState() => _ProductsByBrandScreenState();
}

class _ProductsByBrandScreenState extends State<ProductsByBrandScreen> {
  var _isInit = true;
  var _isLoading = false;
  var _brandSelected = '';

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
        _brandSelected = ModalRoute.of(context).settings.arguments;
      });
      Provider.of<Products>(context)
          .fetchProductsByBrand(_brandSelected)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_brandSelected Products'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(),
    );
  }
}
