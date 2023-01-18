import 'package:flutter/material.dart';

import 'charger/charger_list.dart';
import 'feedback/feedback_list.dart';
import 'product/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: pc,
          onPageChanged: setPaginaAtual,
          children: const [
            ProductListPage(),
            ChargeListPage(),
            FeedbacksListPage()
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.blueAccent,
          child: BottomNavigationBar(
            currentIndex: paginaAtual,
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedItemColor: Colors.amber,
            unselectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.car_repair), label: 'Vehicles'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_gas_station), label: 'Charger'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.star), label: 'Feedback'),
            ],
            onTap: (pagina) {
              pc.animateToPage(
                pagina,
                duration: const Duration(milliseconds: 400),
                curve: Curves.ease,
              );
            },
          ),
        ));
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }
}
