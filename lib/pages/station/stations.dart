// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/navigation_drawer.dart';
import '../../models/station.dart';

class Stations extends StatelessWidget {
  List<Station> items = [
    Station(
        address: 'Rua Domingos da Fonseca, 34-SP',
        cellphone: '',
        connectors: 'CCS/SAE & Type 2',
        information:
            'Dois pontos de recarga rápida CCS e dois pontos de recarga lenta tipo 2. Requer aplicativo próprio para desbloqueio do carregador.',
        name: 'HUB EZVolt - Mooca',
        map: 'map1.png',
        url: 'https://goo.gl/maps/jqL5NDJ2LB5ioBbZ9',
        id: 1),
    Station(
        address: 'Condessa Elizabeth de Robiano 1750-SP',
        cellphone: '0800 335 0034',
        connectors: 'J-1772, CHAdeMO & CCS/SAE',
        information:
            'Dois conectores CCS, carregador distribui a carga entre dois carros que podem carregar ao mesmo tempo',
        name: 'Movida Tatuapé - Zletrica',
        map: 'map10.png',
        url: 'https://goo.gl/maps/E5cDzwejbQLskVq98',
        id: 2),
    Station(
        address: 'Av. Dr. Cardoso de Melo, 1507-SP',
        cellphone: '+55 11 5644-6700',
        connectors: 'J-1772, CHAdeMO & CCS/SAE',
        information:
            'Dois conectores CCS, carregador distribui a carga entre dois carros que podem carregar ao mesmo tempo',
        name: 'Porsche Center São Paulo',
        map: 'map9.png',
        url: 'https://goo.gl/maps/74oxKFZWhfqX8hT46',
        id: 3),
    Station(
        address: 'Av. Prof. Celestino Bourroul, 34-SP',
        cellphone: '+55 800 020 2871',
        connectors: 'CHAdeMO & CCS/SAE',
        information:
            'Para acessar as estações de recarga o usuário deverá baixar o aplicativo Tupinambá, conectar o plug no veículo e se identificar através de QR code que estará nos Carregadores ou então por uma Tag RFID cadastrada junto a seu perfil no aplicativo.',
        name: 'Shell Recharge | Posto Papa - Marginal Tietê',
        map: 'map8.png',
        url: 'https://goo.gl/maps/VSAJsKCpdHgJna276',
        id: 4),
    Station(
        address: 'R. Clodomiro Amazonas, 1024-SP',
        cellphone: '',
        connectors: 'CCS/SAE',
        information: 'Carregador conectado à rede da Tupinambá Energia.',
        name: 'AUDI CENTER ITAIM',
        map: 'map6.png',
        url: 'https://goo.gl/maps/YsmN6GeX8XgLKFKYA',
        id: 5),
    Station(
        address: 'R. Alvarenga, 744-SP',
        cellphone: '+55 11 3816-3000',
        connectors: 'CCS/SAE',
        information:
            'Fica no estacionamento, no Subsolo. Não cobra estacionamento',
        name: 'ENG DTP & Multimídia - Type 2 - 22KW',
        map: 'map5.png',
        url: 'https://goo.gl/maps/1g6PH2y7E3LLPfLV6',
        id: 6),
    Station(
        address: 'Av. Min. Evandro Lins e Silva, 10/100-SP',
        cellphone: '',
        connectors: 'CCS/SAE',
        information: 'Dois carregadores 7kW Zletric',
        name: 'Zletric - Marriott SP Airport',
        map: 'map7.png',
        url: 'https://goo.gl/maps/Lyrx6qwSDUy5dD2W8',
        id: 7),
    Station(
        address: 'Av. Santo Amaro, 4789-SP',
        cellphone: '(11) 99250-074',
        connectors: 'Type 2',
        information: 'Carregador conectado à rede da Tupinambá Energia.',
        name: 'Carrefour Brooklin',
        map: 'map3.png',
        url: 'https://goo.gl/maps/PPPg4ZKsh6SKbZHg7',
        id: 8),
    Station(
        address: 'Avenida Corifeu de Azevedo Marques, 5118-SP',
        cellphone: '',
        connectors: 'Type 2',
        information: 'BYD 40KW - Carregador dentro da loja',
        name: 'Centro Automotivo Porto Seguro - Osasco',
        map: 'map2.png',
        url: '',
        id: 9),
    Station(
        address: 'Av. Presidente Wilson, 5080-SP',
        cellphone: '(11) 99130-0222',
        connectors: 'Type 2 & Wall (Euro)',
        information: '',
        name: 'Jac Motors Vila Mariana',
        map: 'map4.png',
        url: 'https://goo.gl/maps/UkQoSdjx2isiCVbh7',
        id: 10),
  ];

  Stations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          centerTitle: true,
          elevation: 0.0,
          title: const Text('Charge Stations',
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
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) => buildCard(items[index])),
            separatorBuilder: ((context, index) => const SizedBox(width: 20)),
          ),
        ));
  }

  Widget buildCard(Station station) {
    return GestureDetector(
        onTap: () async {
          launchUrl(Uri.parse(station.url),
              mode: LaunchMode.externalApplication);
        },
        child: Container(
            margin: const EdgeInsets.all(16),
            width: 230,
            decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                )),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 280,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: AssetImage(
                            'assets/images/${station.map}',
                          )),
                    ),
                  ),
                  SizedBox(
                      height: 170,
                      child: Column(children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 12, left: 16, right: 16),
                          child: Text(
                            station.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(16),
                          child: Text(
                            station.address,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ]))
                ])));
  }
}
