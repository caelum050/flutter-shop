import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/user_brand_item.dart';

import '../screens/add_edit_brand_screen.dart';

import '../providers/brands.dart';

class UserBrandsScreen extends StatefulWidget {
  static const routeName = '/user-brands';

  @override
  _UserBrandsScreenState createState() => _UserBrandsScreenState();
}

class _UserBrandsScreenState extends State<UserBrandsScreen> {
  var _isInit = true;
  var _isLoading = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Brand>(context).fecthandSetBrands().then((_) {
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
    final brands = Provider.of<Brand>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Brands'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddEditBrandScreen.routeName);
              }),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: brands.brands.length,
                itemBuilder: (_, i) => Column(
                      children: <Widget>[
                        UserBrandItem(
                          brands.brands[i].id,
                          brands.brands[i].name,
                          brands.brands[i].description,
                          brands.brands[i].imageUrl,
                        ),
                        Divider(),
                      ],
                    )),
      ),
    );
  }
}
