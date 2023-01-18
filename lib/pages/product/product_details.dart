import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/navigation_drawer.dart';
import '../../models/product.dart';
import '../../utils/product_color.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      drawer: const NavigationDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: Container(
          height: 80,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                'assets/images/${product.image}',
              )),
              borderRadius:
                  const BorderRadius.only(bottomRight: Radius.circular(90))),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: ProductColor.mapColors[product.color],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      )),
                  child: Column(children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                'assets/images/${product.barCode}.png',
                              )),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      product.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 20),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        product.descripion,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ])),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () async {
            launchUrl(Uri.parse('https://www.stellantis.com/en'),
                mode: LaunchMode.externalApplication);
          },
          child: const Icon(Icons.business)),
    );
  }
}
