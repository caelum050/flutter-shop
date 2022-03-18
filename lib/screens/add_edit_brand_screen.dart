import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/brands.dart';

class AddEditBrandScreen extends StatefulWidget {
  static const routeName = 'add-edit-brand';
  @override
  _AddEditBrandScreenState createState() => _AddEditBrandScreenState();
}

class _AddEditBrandScreenState extends State<AddEditBrandScreen> {
  var _isLoading = false;
  var _isInit = true;
  final _descriptionUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedBrand =
      BrandItem(id: null, name: '', description: '', imageUrl: '');
  var _initValues = {
    'name': '',
    'description': '',
    'imageUrl': '',
  };

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final brandId = ModalRoute.of(context).settings.arguments as String;
      if (brandId != null) {
        _editedBrand = Provider.of<Brand>(context).findById(brandId);
      }
      _initValues = {
        'name': _editedBrand.name,
        'description': _editedBrand.description,
        //'imageUrl': _editedBrand.imageUrl,
        'imageUrl': ''
      };
      _imageUrlController.text = _editedBrand.imageUrl;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _descriptionUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    _form.currentState.save();
    if (_editedBrand.id != null) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Brand>(context, listen: false)
          .updateBrand(_editedBrand.id, _editedBrand)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });
    } else {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Brand>(context, listen: false)
          .addBrand(_editedBrand)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Brand'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                  key: _form,
                  child: ListView(
                    children: <Widget>[
                      TextFormField(
                        initialValue: _initValues['name'],
                        decoration: InputDecoration(labelText: 'Name'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionUrlFocusNode);
                        },
                        onSaved: (value) {
                          _editedBrand = BrandItem(
                              id: _editedBrand.id,
                              name: value,
                              description: _editedBrand.description,
                              imageUrl: _editedBrand.imageUrl);
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['description'],
                        decoration: InputDecoration(labelText: 'Description'),
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        focusNode: _descriptionUrlFocusNode,
                        onSaved: (value) {
                          _editedBrand = BrandItem(
                              id: _editedBrand.id,
                              name: _editedBrand.name,
                              description: value,
                              imageUrl: _editedBrand.imageUrl);
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(top: 8, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                            ),
                            child: _imageUrlController.text.isEmpty
                                ? Text('Enter a URL')
                                : FittedBox(
                                    child: Image.network(
                                      _imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Image URL'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageUrlController,
                              focusNode: _imageUrlFocusNode,
                              onFieldSubmitted: (_) {
                                _saveForm();
                              },
                              onSaved: (value) {
                                _editedBrand = BrandItem(
                                    id: _editedBrand.id,
                                    name: _editedBrand.name,
                                    description: _editedBrand.description,
                                    imageUrl: value);
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            ),
    );
  }
}
