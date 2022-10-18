import 'package:ecom/pages/product_detail.dart';
import 'package:ecom/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';

class ProductWidget extends StatelessWidget {
  // final Product product;

  // ProductWidget(this.product);

  @override
  Widget build(BuildContext context) {
    // final productProvider = Provider.of(context)<Product>;
    final product = Provider.of<Product>(context);
    final cart = Provider.of<CartProvider>(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetail.routeName, arguments: {'id': product.id});
      },
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.white54,
            leading: IconButton(
              onPressed: () {
                cart.addItem(product.id);
              },
              icon: Icon(
                Icons.add_shopping_cart,
              ),
              color: Colors.black,
            ),
            title: Text(
              style: TextStyle(color: Colors.black),
              product.title,
              textAlign: TextAlign.end,
            ),
            subtitle: Text(
              product.price.toString(),
              style: TextStyle(color: Colors.black),
            ),
            trailing: IconButton(
                icon: product.isFavourite
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),
                onPressed: () {
                  product.toggleFavourite();
                },
                color: Colors.black),
          ),
          child: Container(
            height: 200,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );

    // Card(
    //   color: Colors.black54,
    //   elevation: 4,
    //   child: Column(children: [
    //     Stack(
    //       alignment: AlignmentDirectional.bottomStart,
    //       children: [
    //         Image.network(product.imageUrl,
    //         // width:,
    //         fit: BoxFit.fitWidth,),
    //         Positioned(
    //           child: Icon(Icons.add_shopping_cart),
    //           top: 100,
    //         ),
    //         Positioned(
    //           child: Icon(Icons.favorite),
    //           top: 100,
    //           left: 100,
    //         )
    //       ],
    //     ),
    //     Container(
    //       color: Colors.amber,
    //       child: Row(

    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         children: [
    //           Text(product.title),
    //           Text('\$${product.price.toString()}')
    //         ],
    //       ),
    //     )
    //   ]),
    // );
  }
}
