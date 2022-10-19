import 'package:ecom/providers/product.dart';
import 'package:ecom/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class EditProductPage extends StatefulWidget {
  static const routeName = '/edit-product';
  const EditProductPage({super.key});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: 0,
    title: 'dddd',
    price: 0,
    description: '',
    imageUrl: '',
  );

    var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isInit = true;

  void saveForm() {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
    if (_editedProduct.id != null) {
      Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_editedProduct.id.toString(), _editedProduct);
    } else {
      Provider.of<ProductsProvider>(context, listen: false).addProduct(_editedProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
  
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<ProductsProvider>(context, listen: false).findById(int.parse(productId));
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;

// TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Form(
          key: _form,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            children: [
              // TextField(),
              TextFormField(
                 initialValue: _initValues['title'],
                decoration: InputDecoration(
                    label: Text("Title"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: BorderSide(width: 2))),
                textInputAction: TextInputAction.next,
                onSaved: ((newValue) {
                  _editedProduct = Product(
                    id: 0,
                    title: newValue.toString(),
                    imageUrl: _editedProduct.imageUrl,
                    price: _editedProduct.price,
                    description: _editedProduct.description,
                  );
                }),
              ),
              TextFormField(
                 initialValue: _initValues['price'],
                decoration: InputDecoration(
                    label: Text("Price"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: BorderSide(width: 2))),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                // focusNode: _priceFocusNode,
                onSaved: ((newValue) {
                  _editedProduct = Product(
                    id: 0,
                    title: _editedProduct.title,
                    price:  double.parse(newValue.toString()),
                    description: _editedProduct.description,
                    imageUrl:_editedProduct.imageUrl,
                  );
                }),
              ),
              TextFormField(
                 initialValue: _initValues['description'],
                maxLines: 3,
                decoration: InputDecoration(
                    label: Text("Description"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: BorderSide(width: 2))),
                textInputAction: TextInputAction.next,
                // focusNode: _descriptionFocusNode,
                onSaved: ((newValue) {
                  _editedProduct = Product(
                    id: 0,
                    title:_editedProduct.title ,
                    price: _editedProduct.price,
                    description: newValue.toString(),
                    imageUrl: _editedProduct.imageUrl,
                  );
                }),
              ),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.amber)),
                    child: _imageUrlController.text.isEmpty
                        ? Text("Please enter an image URL")
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                       initialValue: _initValues['imageUrl'],
                      decoration: InputDecoration(
                          label: Text("Image URL"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide: BorderSide(width: 2))),
                      textInputAction: TextInputAction.done,
                      // focusNode: _imageUrlFocusNode,
                      // controller: _imageUrlController,
                      onSaved: ((newValue) {
                        _editedProduct = Product(
                          id: 0,
                          title: _editedProduct.title,
                          price: _editedProduct.price,
                          description: _editedProduct.description,
                          imageUrl: newValue.toString(),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    saveForm();
                  },
                  child: Text("Submit"))
            ],
          )),
    );
  }
}
