// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../components/navigation_drawer.dart';
import '../../models/feedback.dart';
import '../../models/product.dart';
import '../../repository/feedback_repository.dart';
import '../../repository/product_repository.dart';

class FeedbacksRegistryPage extends StatefulWidget {
  Feedbacks? feedbackforEdit;
  FeedbacksRegistryPage({Key? key, this.feedbackforEdit}) : super(key: key);

  @override
  State<FeedbacksRegistryPage> createState() => _FeedbacksRegistryPageState();
}

class _FeedbacksRegistryPageState extends State<FeedbacksRegistryPage> {
  final _productRepository = ProductRepository();
  final _feedbackRepository = FeedbacksRepository();
  final _ratingController = TextEditingController();
  final _evaluationController = TextEditingController();

  final maskFormatterRate =
      MaskTextInputFormatter(mask: '#.#', filter: {"#": RegExp(r'[0-9]')});

  Product? _productSelected;
  List<Product> _product = [];

  @override
  void initState() {
    super.initState();

    final feedback = widget.feedbackforEdit;
    if (feedback != null) {
      _evaluationController.text = feedback.evaluation;
      _ratingController.text = feedback.rating;
      _productSelected = feedback.product;
    }

    loadProducts();
  }

  Future<void> loadProducts() async {
    final product = await _productRepository.listProduct();

    setState(() {
      _product = product.toList();
    });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(90))),
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
                            'Feedback',
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
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          _buildEvaluation(),
                          _buildRating(),
                          _buildProduct(),
                          _buildButton()
                        ],
                      ),
                    ),
                  ),
                ),
              ])),
        ));
  }

  Container _buildButton() {
    return Container(
        height: 45,
        width: MediaQuery.of(context).size.width / 1.2,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Center(
          child: TextButton(
            child: Text(
              'REGISTRY'.toUpperCase(),
              style: const TextStyle(
                  color: Colors.lightGreen, fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              final isValid = _formKey.currentState!.validate();
              if (isValid) {
                final evaluation = _evaluationController.text;
                final rating = _ratingController.text;
                final product = _productSelected!;
                final feedback = Feedbacks(
                  evaluation: evaluation,
                  rating: rating,
                  product: product,
                );

                try {
                  if (widget.feedbackforEdit != null) {
                    feedback.id = widget.feedbackforEdit!.id;
                    await _feedbackRepository.editFeedbacks(feedback);
                  } else {
                    await _feedbackRepository.registerFeedbacks(feedback);
                  }

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Feedback registred successfully!'),
                  ));

                  Navigator.of(context).pop(true);
                } catch (e) {
                  Navigator.of(context).pop(false);
                }
              }
            },
          ),
        ));
  }

  Container _buildEvaluation() {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height * 0.08,
        padding: const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            border: Border.all(color: Colors.white),
            color: Colors.transparent,
            boxShadow: const [
              BoxShadow(color: Colors.transparent, blurRadius: 5)
            ]),
        child: TextFormField(
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          controller: _evaluationController,
          maxLines: 3,
          keyboardType: TextInputType.text,
          textAlignVertical: TextAlignVertical.center,
          decoration: const InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              Icons.comment,
              color: Colors.white,
            ),
            hintStyle: TextStyle(color: Colors.white),
            hintText: 'Evaluation',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Evaluation';
            }
            if (value.length < 5 || value.length > 60) {
              return 'The evaluation must be between 5 and 60 characters';
            }
            return null;
          },
        ));
  }

  Container _buildRating() {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height * 0.08,
        padding: const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            border: Border.all(color: Colors.white),
            color: Colors.transparent,
            boxShadow: const [
              BoxShadow(color: Colors.transparent, blurRadius: 5)
            ]),
        child: TextFormField(
          controller: _ratingController,
          inputFormatters: [maskFormatterRate],
          keyboardType: TextInputType.number,
          textAlignVertical: TextAlignVertical.center,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
            icon: Icon(
              Icons.star,
              color: Colors.white,
            ),
            hintText: 'Rating',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Fill in a Rating';
            }
            return null;
          },
        ));
  }

  Container _buildProduct() {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height * 0.1,
        padding: const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            border: Border.all(color: Colors.white),
            color: Colors.transparent,
            boxShadow: const [
              BoxShadow(color: Colors.transparent, blurRadius: 5)
            ]),
        child: DropdownButtonFormField<Product>(
          dropdownColor: Colors.white,
          value: _productSelected,
          items: _product.map((d) {
            return DropdownMenuItem<Product>(
              value: d,
              child: Text(d.name),
            );
          }).toList(),
          onChanged: (Product? product) {
            setState(() {
              _productSelected = product;
            });
          },
          decoration: const InputDecoration(
            labelText: 'Product',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
            labelStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
          validator: (value) {
            if (value == null) {
              return 'Select a Product';
            }
            return null;
          },
        ));
  }
}
