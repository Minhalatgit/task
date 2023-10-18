import 'package:flutter/material.dart';
import 'package:task/product.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView(this.map, {Key? key}) : super(key: key);
  final dynamic map;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> with TickerProviderStateMixin {
  late Product _product;

  @override
  void initState() {
    super.initState();
    if (widget.map != null && widget.map["product"] != null) {
      _product = widget.map["product"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_product.title ?? ""),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(_product.image ?? ""),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${_product.price}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_product.description ?? ""),
                  Row(
                    children: [
                      const Icon(Icons.star),
                      Text(
                        '${_product.rating?.rate} (${_product.rating?.count} reviews)',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
