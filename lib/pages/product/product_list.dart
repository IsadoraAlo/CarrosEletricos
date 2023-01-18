import 'package:flutter/material.dart';

import '../../components/navigation_drawer.dart';
import '../../models/product.dart';
import '../../repository/product_repository.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final _productRepository = ProductRepository();
  late Future<List<Product>> _futureProduct;

  @override
  void initState() {
    loadProduct();
    super.initState();
  }

  void loadProduct() {
    _futureProduct = _productRepository.listProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        centerTitle: true,
        elevation: 0.0,
        title: const Text('Vehicles',
            style: TextStyle(
                color: Colors.blueAccent, fontWeight: FontWeight.w800)),
        iconTheme: const IconThemeData(color: Colors.blueAccent),
      ),
      drawer: const NavigationDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: FutureBuilder<List<Product>>(
          future: _futureProduct,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              final feedbacks = snapshot.data ?? [];
              return ListView.separated(
                  itemCount: feedbacks.length,
                  itemBuilder: (context, index) {
                    final product = feedbacks[index];
                    return ProductListItem(product: product);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 0,
                        height: 0,
                      ));
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: () async {
            bool? productRegistration =
                await Navigator.of(context).pushNamed('/station-list') as bool?;

            if (productRegistration != null && productRegistration) {
              setState(() {
                loadProduct();
              });
            }
          },
          child: const Icon(Icons.local_gas_station)),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

class ProductListItem extends StatelessWidget {
  final Product product;
  const ProductListItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/${product.image}')),
            ),
            child: ListTile(
              subtitle: Text(product.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
              onTap: () {
                Navigator.pushNamed(context, '/product-details',
                    arguments: product);
              },
            )));
  }
}
