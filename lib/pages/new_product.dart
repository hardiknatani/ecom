import 'package:ecom/providers/product.dart';
import 'package:ecom/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class NewProductPage extends StatefulWidget {
  static const routeName = '/new-product';
  const NewProductPage({super.key});

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _newProductForm = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: 0,
    title: 'dddd',
    price: 0,
    description: '',
    imageUrl: '',
  );


  void saveForm() {
    final isValid = _newProductForm.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _newProductForm.currentState?.save();

      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(_editedProduct);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }



  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
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
          key: _newProductForm,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            children: [
              // TextField(),
              TextFormField(

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

                decoration: InputDecoration(
                    label: Text("Price"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: BorderSide(width: 2))),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onSaved: ((newValue) {
                  _editedProduct = Product(
                    id: 0,
                    title: _editedProduct.title,
                    price: double.parse(newValue.toString()),
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                  );
                }),
              ),
              TextFormField(

                maxLines: 3,
                decoration: InputDecoration(
                    label: Text("Description"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: BorderSide(width: 2))),
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocusNode,
                onSaved: ((newValue) {
                  _editedProduct = Product(
                    id: 0,
                    title: _editedProduct.title,
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
                    child: _imageUrlController.text.isEmpty ||
                            _imageUrlController.text == null
                        ? Text("Please enter an image URL")
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          label: Text("Image URL"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide: BorderSide(width: 2))),
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocusNode,
                      controller: _imageUrlController,
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
