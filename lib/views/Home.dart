import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../Model/Cart.dart';
import '../Model/Categories.dart';
import '../Model/Product.dart';
import '../Provider/CartProvider.dart';
import '../Provider/ProductNotifier.dart';
import '../Theme/TheameProvider.dart';
import 'CartItem.dart';
import 'Search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> categories = [];
  List<Product> products = [];
  int productCount = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    loadCategories();
    loadProducts();
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  void dispose() {
    // Cancel any timers, subscriptions, etc. here
    super.dispose();
  }

  Future<void> loadCategories() async {
    final String categoriesCsv =
        await rootBundle.loadString('assets/csv/CATEGORY_MOCK_DATA.csv');
    List<List<dynamic>> categoriesList =
        const CsvToListConverter().convert(categoriesCsv);
    List<Category> parsedCategories = categoriesList
        .skip(1)
        .map((List<dynamic> category) => Category(
              id: category[0],
              categoryName: category[1],
              subCategoryName: category[2],
              imageUrl: category[3],
            ))
        .toList();

    setState(() {
      categories = parsedCategories;
    });
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Provider.of<ThemeProvider>(context).isDarkMode ? Icon(Icons.light_mode_outlined) : Icon(Icons.dark_mode_outlined),
            onPressed: () {
              // Toggle dark mode using the ThemeProvider
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },

          ),
        ],
        title: const Padding(
          padding: EdgeInsets.only(left: 22.0),
          child: Text(
            'Home',
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Skeletonizer(
        enabled: _loading,
        child: ListView(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                CarouselSection(),
                CategoriesSection(categories, (category) {
                  // Navigate to a new screen or show a bottom sheet with related products
                  showRelatedProducts(context, category);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showRelatedProducts(BuildContext context, Category category) {
    List<Product> relatedProducts = products
        .where((product) => product.subCategory == category.subCategoryName)
        .toList();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: relatedProducts.length,
            itemBuilder: (BuildContext context, int index) {
              Product product = relatedProducts[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                                "Price: \₹${product.price.toInt()}",
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
        );
      },
    );
  }

  // void addToCart(BuildContext context, Product product) {
  //   // Get the CartProvider from the context
  //   CartProvider cartProvider =
  //       Provider.of<CartProvider>(context, listen: false);
  //
  //   // Add the Product to the cart based on its quantity
  //   for (int i = 0; i < product.quantity; i++) {
  //     // Create a CartItem for each quantity
  //     CartItem cartItem = CartItem(
  //       productId: product.id,
  //       productName: product.name,
  //       price: product.price,
  //     );
  //
  //     // Add the CartItem to the cart
  //     cartProvider.addToCart(cartItem);
  //   }
  //
  //   // Reset the quantity to 0
  //   product.quantity = 0;
  //
  //   // Close the bottom sheet
  //   Navigator.pop(context);
  // }
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

    AnimatedSnackBar.material(
      'The Item Added to Cart',
      type: AnimatedSnackBarType.success,
    ).show(context);
  }
}

class CarouselSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 8, // Adjust based on your image count
      options: CarouselOptions(
        height: 250.0, // Adjusted for better card presentation
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index, reason) {},
      ),
      itemBuilder: (context, index, realIndex) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0), // Enhanced card look
            child: Stack(
              children: [
                Image.asset(
                  'assets/Images/$index.jpeg', // Replace with your image path
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                // Positioned(
                //   bottom: 20.0,
                //   left: 20.0,
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 10.0, vertical: 5.0),
                //     decoration: BoxDecoration(
                //       color: Colors.black.withOpacity(0.5),
                //       borderRadius: BorderRadius.circular(10.0),
                //     ),
                //     child: Text(
                //       'Image Title $index', // Replace with actual titles
                //       style: const TextStyle(
                //         color: Colors.white,
                //         fontSize: 16.0,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CategoriesSection extends StatelessWidget {
  final List<Category> categories;
  final Function(Category) onCategorySelected;

  CategoriesSection(this.categories, this.onCategorySelected);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Categories',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 350,
          child: ListView(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      onCategorySelected(categories[index]);
                    },
                    child: Card(

                      child: Column(
                        children: [
                          Container(
                            height: 105.0,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              image: DecorationImage(
                                image: AssetImage(categories[index].imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              categories[index].subCategoryName,
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     // Add to cart logic
                          //   },
                          //   child: Text('Add to Cart'),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
