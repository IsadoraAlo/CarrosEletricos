import 'package:flutter/material.dart';
import 'pages/charger/charger_details.dart';
import 'pages/charger/charger_registration.dart';
import 'pages/feedback/feedback_details.dart';
import 'pages/feedback/feedback_registry.dart';
import 'pages/station/stations.dart';
import 'pages/user/about_page.dart';
import 'pages/user/user_registry_page.dart';
import 'pages/home.dart';
import 'pages/product/product_details.dart';
import 'pages/user/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => const LoginPage(),
        '/user-registry': (context) => const UserRegistry(),
        '/home': (context) => const HomePage(),
        '/product-details': (context) => const ProductDetailPage(),
        '/station-list': (context) => Stations(),
        '/feedback-details': (context) => const FeedbacksDetailPage(),
        '/feedback-registry': (context) => FeedbacksRegistryPage(),
        '/charge-details': (context) => const ChargerDetailPage(),
        '/charge-registry': (context) => ChargeRegistryPage(),
        '/team-details': (context) => AboutPage(),
      },
      initialRoute: '/login',
    );
  }
}
