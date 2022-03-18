import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';

import '../providers/products.dart';
import '../providers/cart.dart';

import '../screens/cart_screen.dart';

class CompleteSkateboardsScreen extends StatefulWidget {
  static const routeName = '/complete-skateboard';

  @override
  _CompleteSkateboardsScreenState createState() =>
      _CompleteSkateboardsScreenState();
}

class _CompleteSkateboardsScreenState extends State<CompleteSkateboardsScreen> {
  var _isInit = true;
  var _isLoading = false;
  var _currentCategory = 'Complete';

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
        title: Text('All Complete Skateboards'),
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
