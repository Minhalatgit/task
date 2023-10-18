import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:task/app_routes.dart';
import 'package:task/product.dart';
import 'package:http/http.dart' as http;

class ProductsView extends StatefulWidget {
  const ProductsView(this.map, {Key? key}) : super(key: key);
  final dynamic map;

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> with TickerProviderStateMixin {
  final PagingController<int, Product> _pagingController = PagingController(firstPageKey: 1);

  int _limit = 10;

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      _getProductsData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
        // automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.signInView, (route) => false);
            },
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: PagedListView(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Product>(
          itemBuilder: (context, item, index) => Card(
            child: ListTile(
              leading: Image.network(
                item.image ?? "",
                width: 50,
              ),
              title: Text(item.title ?? ""),
              subtitle: Text('\$${item.price}'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                var map = {"product": item};
                Navigator.pushNamed(context, AppRoutes.productDetailView, arguments: map);
              },
            ),
          ),
        ),
      ),
    );
  }

  void _getProductsData() async {
    try {

      print("_limit: $_limit");

      var response = await http.get(Uri.parse('https://fakestoreapi.com/products?limit=$_limit'));
      print("Response ---> ${jsonDecode(response.body).runtimeType}");

      List<Product> products = (jsonDecode(response.body) as List).map((item) => Product.fromJson(item)).toList();

      _limit = _limit + 10;

      _pagingController.appendPage(products, 1);
    } on Exception catch (e) {
      _pagingController.error = e;
    }
  }
}
