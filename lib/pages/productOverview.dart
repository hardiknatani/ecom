import 'package:ecom/data/products_data.dart';
import 'package:ecom/pages/cart_page.dart';
import 'package:ecom/providers/cart_provider.dart';
import 'package:ecom/providers/product.dart';
import 'package:ecom/providers/products_provider.dart';
import 'package:ecom/widgets/drawer.dart';
import 'package:ecom/widgets/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../widgets/badge.dart';

class ProductOverview extends StatefulWidget {
  // static const routeName = '/shop';
  const ProductOverview({super.key});

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  bool isFavouriteFilter = false;
  var isInit = true;
  var isLoading = false;

  @override
  void initState() {
    checkConnectivity();
    // TODO: implement initState

    // Future.delayed(Duration.zero).then((_) {
    //   final products = Provider.of<ProductsProvider>(context).getProducts;
    //   print(products);
    // });

    super.initState();
  }

  void checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print('connected');
    } else {
      print('No Internet Connection');
    }
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchProducts().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
    
  }

  @override
  Widget build(BuildContext context) {

    //  print(Provider.of<ProductsProvider>(context).items);
    return Consumer<ProductsProvider>(
      builder: ((context, provider, child) => Scaffold(
            appBar: AppBar(
              title: Text("Shop"),
              actions: [
                PopupMenuButton(
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () {
                              setState(() {
                                isFavouriteFilter = true;
                              });
                            },
                            child: Text('Only Favourites'),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              setState(() {
                                isFavouriteFilter = false;
                              });
                            },
                            child: Text('Show All'),
                          )
                        ]),
                Consumer<CartProvider>(
                  builder: (context, cart, child) => Badge(
                      child: IconButton(
                        icon: Icon(
                          Icons.shopping_cart,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(CartPage.routeName);
                        },
                      ),
                      value: cart.itemCount.toString()),
                )
              ],
            ),
            drawer: MainDrawer(),
            body: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView(
                    padding: EdgeInsets.all(15),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        // childAspectRatio: 3.5 / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    children: isFavouriteFilter
                        ? provider.items
                            .where((element) => element.isFavourite == true)
                            .map(
                              (product) => ChangeNotifierProvider.value(
                                  value: product, child: ProductWidget()),
                            )
                            .toList()
                        : provider.items
                            .map(
                              (product) => ChangeNotifierProvider.value(
                                  value: product, child: ProductWidget()),
                            )
                            .toList(),
                  ),
            // floatingActionButton: FloatingActionButton(
            //     child: Text('+'),
            //     onPressed: () {
            //       provider.addProduct(Product(
            //           id: 1,
            //           title: 'Orange',
            //           description: "description",
            //           imageUrl:
            //               "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTJFW0AaaaDWz7AzrVtOeCVrptS_uf2d5W4g&usqp=CAU",
            //           price: 20));
            //     }),
          )),
    );
  }
}
