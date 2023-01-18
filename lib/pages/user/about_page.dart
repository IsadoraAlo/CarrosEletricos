// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../components/navigation_drawer.dart';
import '../../models/integrantes.dart';

class AboutPage extends StatelessWidget {
  List<Integrantes> items = [
    const Integrantes(
        image: 'isa',
        name: 'Isadora Alves Lino de Oliveira',
        rm: '(11) 99110-1422'),
  ];

  AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          centerTitle: true,
          elevation: 0.0,
          title: const Text('About Us',
              style: TextStyle(
                  color: Colors.blueAccent, fontWeight: FontWeight.w800)),
          iconTheme: const IconThemeData(color: Colors.blueAccent),
        ),
        drawer: const NavigationDrawer(),
        body: Container(
          width: 500,
          height: 500,
          margin: const EdgeInsets.all(20),
          child: ListView.separated(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) => buildCard(items[index])),
            separatorBuilder: ((context, index) => const SizedBox(width: 20)),
          ),
        ));
  }

  Widget buildCard(Integrantes integrante) {
    return Container(
        width: 500,
        height: 500,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  'assets/images/${integrante.image}.jpg',
                )),
            borderRadius: const BorderRadius.all(
              Radius.circular(50),
            )),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  integrante.name,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  integrante.rm,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                )
              ]),
        ));
  }
}
