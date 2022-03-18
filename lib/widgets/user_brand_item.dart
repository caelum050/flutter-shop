import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_edit_brand_screen.dart';

import '../providers/brands.dart';

class UserBrandItem extends StatelessWidget {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  UserBrandItem(this.id, this.name, this.description, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AddEditBrandScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<Brand>(context, listen: false).deleteBrand(id);
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
