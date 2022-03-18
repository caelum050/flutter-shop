import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/brands_screens.dart';
import '../screens/decks_screen.dart';
import '../screens/trucks_screen.dart';
import '../screens/wheels_screens.dart';
import '../screens/complete_skateboards_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../screens/user_brands_screen.dart';

import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          AppBar(
            title: Text('Skate Skies'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.perm_identity),
            title: Text('User'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Brands'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserBrandsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Brands'),
            onTap: () {
              Navigator.of(context).pushNamed(BrandsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Decks'),
            onTap: () {
              Navigator.of(context).pushNamed(DecksScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Trucks'),
            onTap: () {
              Navigator.of(context).pushNamed(TrucksScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Wheels'),
            onTap: () {
              Navigator.of(context).pushNamed(WheelsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Complete Skateboards'),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(CompleteSkateboardsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
