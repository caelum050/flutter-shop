import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';

import '../providers/products.dart';
import '../providers/cart.dart';

import '../screens/cart_screen.dart';

class TrucksScreen extends StatefulWidget {
  static const routeName = '/trucks';

  @override
  _TrucksScreenState createState() => _TrucksScreenState();
}

class _TrucksScreenState extends State<TrucksScreen> {
  var _isInit = true;
  var _isLoading = false;
  var _currentCategory = 'Trucks';

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context)
          .fetchProductsByCategory(_currentCategory)
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
        title: Text('All Trucks'),
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
                }),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(),
    );
  }
}
