import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/auth_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_details_screen.dart';
import './screens/brands_screens.dart';
import './screens/decks_screen.dart';
import './screens/trucks_screen.dart';
import './screens/wheels_screens.dart';
import './screens/complete_skateboards_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/user_brands_screen.dart';
import './screens/add_edit_brand_screen.dart';
import './screens/add_edit_product_screen.dart';
import './screens/products_by_brand_screen.dart';

import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/brands.dart';
import './providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: null,
            update: (ctx, authData, previousProducts) => Products(
                authData.token,
                previousProducts == null ? [] : previousProducts.items),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: null,
            update: (ctx, authData, previousOrders) => Orders(
                authData.token,
                authData.userId,
                previousOrders == null ? [] : previousOrders.orders),
          ),
          ChangeNotifierProxyProvider<Auth, Brand>(
            create: null,
            update: (ctx, authData, previousBrands) => Brand(authData.token,
                previousBrands == null ? [] : previousBrands.brands),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, authData, _) => MaterialApp(
            title: 'SkateSkies',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                accentColor: Colors.amber,
                fontFamily: 'Lato'),
            home: authData.isAuth ? ProductsOverviewScreen() : AuthScreen(),
            routes: {
              AuthScreen.routeName: (ctx) => AuthScreen(),
              ProductsOverviewScreen.routeName: (ctx) =>
                  ProductsOverviewScreen(),
              ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
              BrandsScreen.routeName: (ctx) => BrandsScreen(),
              DecksScreen.routeName: (ctx) => DecksScreen(),
              TrucksScreen.routeName: (ctx) => TrucksScreen(),
              WheelsScreen.routeName: (ctx) => WheelsScreen(),
              CompleteSkateboardsScreen.routeName: (ctx) =>
                  CompleteSkateboardsScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              UserBrandsScreen.routeName: (ctx) => UserBrandsScreen(),
              AddEditBrandScreen.routeName: (ctx) => AddEditBrandScreen(),
              AddEditProductScreen.routeName: (ctx) => AddEditProductScreen(),
              ProductsByBrandScreen.routeName: (ctx) => ProductsByBrandScreen(),
            },
          ),
        ));
  }
}
