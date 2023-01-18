// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../components/navigation_drawer.dart';
import '../../models/charge.dart';
import '../../models/product.dart';
import 'package:intl/intl.dart';

import '../../repository/charge_repository.dart';
import '../../repository/product_repository.dart';

class ChargeRegistryPage extends StatefulWidget {
  Charge? chargeforEdit;
  ChargeRegistryPage({Key? key, this.chargeforEdit}) : super(key: key);

  @override
  State<ChargeRegistryPage> createState() => _ChargeRegistryPageState();
}

class _ChargeRegistryPageState extends State<ChargeRegistryPage> {
  final _chargeRepository = ChargeRepository();
  final _dateController = TextEditingController();
  final _productRepository = ProductRepository();
  final _percentController = TextEditingController();

  final maskFormatterPercentage =
      MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});

  Product? _productSelected;
  List<Product> _product = [];

  @override
  void initState() {
    super.initState();

    final charger = widget.chargeforEdit;
    if (charger != null) {
      _dateController.text = DateFormat('MM/dd/yyyy').format(charger.date);
      _productSelected = charger.product;
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
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(90))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Spacer(),
                        Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.local_gas_station,
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
                              'Last Charge',
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
                              child: Column(children: [
                                _buildPercent(),
                                _buildData(),
                                _buildProduct(),
                                _buildButton()
                              ]))))
                ]))));
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
                final percent = _percentController.text;
                final date =
                    DateFormat('dd/MM/yyyy').parse(_dateController.text);
                final product = _productSelected!;
                final charge = Charge(
                  porcentCharged: percent,
                  date: date,
                  product: product,
                );

                try {
                  if (widget.chargeforEdit != null) {
                    charge.id = widget.chargeforEdit!.id;
                    await _chargeRepository.editCharge(charge);
                  } else {
                    await _chargeRepository.registerCharge(charge);
                  }

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Charge registred successfully!'),
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

  Container _buildPercent() {
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
          controller: _percentController,
          inputFormatters: [maskFormatterPercentage],
          keyboardType: TextInputType.number,
          textAlignVertical: TextAlignVertical.center,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
            icon: Icon(
              Icons.percent,
              color: Colors.white,
            ),
            hintText: 'Rating',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Fill in a Percentage';
            }
            if (int.parse(value) > 100 || int.parse(value) < 1) {
              return 'The percentage must have a value between 1 and 100';
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

  Container _buildData() {
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
          controller: _dateController,
          inputFormatters: [maskFormatterPercentage],
          keyboardType: TextInputType.none,
          textAlignVertical: TextAlignVertical.center,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
            icon: Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),
            hintText: 'Date',
          ),
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());

            DateTime? dataSelecionada = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2022),
              lastDate: DateTime.now(),
            );

            if (dataSelecionada != null) {
              _dateController.text =
                  DateFormat('dd/MM/yyyy').format(dataSelecionada);
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Fill a Date';
            }
            // if (value.compareTo(DateTime.now()) > 0)
            //   return 'You are filling in a future date';
            try {
              DateFormat('dd/MM/yyyy').parse(value);
            } on FormatException {
              return 'Invalid date format!';
            }

            return null;
          },
        ));
  }
}
