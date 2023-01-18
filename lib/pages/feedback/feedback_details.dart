import 'package:flutter/material.dart';

import '../../components/navigation_drawer.dart';
import '../../models/feedback.dart';

class FeedbacksDetailPage extends StatelessWidget {
  const FeedbacksDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feedback = ModalRoute.of(context)!.settings.arguments as Feedbacks;

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.blueAccent),
            flexibleSpace: const SizedBox(
              width: 0,
              height: 0,
            )),
        drawer: const NavigationDrawer(),
        body: SingleChildScrollView(
            child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blueAccent, Colors.lightGreen],
                  ),
                ),
                child: Column(children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(90))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Spacer(),
                        Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.person,
                            size: 90,
                            color: Colors.blueAccent,
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 32),
                            child: Text(
                              'Anonymous',
                              style: TextStyle(
                                  color: Colors.blueAccent, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(top: 62),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            feedback.rating,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Product',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            feedback.product.name,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            feedback.evaluation,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 16, top: 16),
                                child: Text(
                                  '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                                  style: const TextStyle(
                                      color: Colors.lightGreen, fontSize: 18),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ]))));
  }
}
