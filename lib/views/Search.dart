import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../Model/Cart.dart';
import '../Model/Product.dart';
import '../Provider/CartProvider.dart';
import 'CartItem.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Product> searchedProducts = [];
  List<Product> products = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();

    loadProducts();

    // searchedProducts = products;
    // print(searchedProducts);
    // print("tttttttttttttttttttt");
  }

  Future<void> loadProducts() async {
    final String productsCsv =
        await rootBundle.loadString('assets/csv/PRODUCTS_MOCK_DATA.csv');
    List<List<dynamic>> productsList =
        const CsvToListConverter().convert(productsCsv);
    List<Product> parsedProducts = productsList
        .skip(1)
        .map((List<dynamic> product) => Product(
              id: product[0],
              name: product[1],
              category: product[2],
              subCategory: product[3],
              availableQuantity: product[4],
              orderedQuantity: product[5],
              price: product[6],
              maxQuantity: product[7],
              // color1: product[8],
              // color2: product[9],
              // color3: product[10],
              // color4: product[11],
              // size1: product[12],
              // size2: product[13],
              // size3: product[14],
              // size4: product[15],
              // size5: product[16],
              // size6: product[17],
              // size7: product[18],
            ))
        .toList();
    setState(() {
      products = parsedProducts;
      searchedProducts = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 22.0),
          child: Text(
            'Search',
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  searchedProducts = products
                      .where((product) => product.name
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                filled: true,
                // fillColor:
                //     Colors.grey[200], // Adjust background color as needed
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search,),
                hintText: 'Search products...',
                // hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16.0),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.amber, width: 2.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchedProducts.length,
              itemBuilder: (BuildContext context, int index) {
                Product product = searchedProducts[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          'assets/mock_images/products/${product.id}.jpg',
                          fit: BoxFit.cover,
                          width: 75, // Adjust image width as needed
                          height: 75, // Adjust image height as needed
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Price: \₹${product.price}",
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                                const Spacer(),
                                CartItemWidget(
                                  product: product,
                                  onAddToCart: (Product product) {
                                    // Add to cart logic
                                    addToCart(context, product);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void addToCart(BuildContext context, Product product) {
    // Get the CartProvider from the context
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);

    // Create a CartItem for the selected product
    CartItem cartItem = CartItem(
      productId: product.id,
      productName: product.name,
      price: product.price,
      quantity:
          product.quantity, // Set quantity based on the product's quantity
    );

    // Add the CartItem to the cart
    cartProvider.addToCart(cartItem);

    // Reset the quantity to 0
    product.quantity = 0;

    // Close the bottom sheet
    AnimatedSnackBar.material(
      'The Item Added to Cart',
      type: AnimatedSnackBarType.success,
    ).show(context);
  }
}
