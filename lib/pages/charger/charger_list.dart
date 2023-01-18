// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:global_solution/pages/charger/charger_registration.dart';

import '../../components/navigation_drawer.dart';
import '../../models/charge.dart';
import '../../repository/charge_repository.dart';

class ChargeListPage extends StatefulWidget {
  const ChargeListPage({Key? key}) : super(key: key);

  @override
  State<ChargeListPage> createState() => _ChargeListPageState();
}

class _ChargeListPageState extends State<ChargeListPage> {
  final _chargeRepository = ChargeRepository();
  late Future<List<Charge>> _futureCharge;

  @override
  void initState() {
    loadCharge();
    super.initState();
  }

  void loadCharge() {
    _futureCharge = _chargeRepository.listCharge();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        centerTitle: true,
        elevation: 0.0,
        title: const Text('Charge',
            style: TextStyle(
                color: Colors.blueAccent, fontWeight: FontWeight.w800)),
        iconTheme: const IconThemeData(color: Colors.blueAccent),
      ),
      drawer: const NavigationDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: FutureBuilder<List<Charge>>(
          future: _futureCharge,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              final charges = snapshot.data ?? [];
              return ListView.separated(
                itemCount: charges.length,
                itemBuilder: (context, index) {
                  final charge = charges[index];
                  return Slidable(
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) async {
                            await _chargeRepository.removeCharge(charge.id!);

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Charge removed successfully!')));

                            setState(() {
                              charges.removeAt(index);
                            });
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Remove',
                        ),
                        SlidableAction(
                          onPressed: (context) async {
                            var success = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ChargeRegistryPage(
                                  chargeforEdit: charge,
                                ),
                              ),
                            ) as bool?;

                            if (success != null && success) {
                              setState(() {
                                loadCharge();
                              });
                            }
                          },
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Edit',
                        ),
                      ],
                    ),
                    child: ChargeListItem(charge: charge),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            bool? chargeCadastrada = await Navigator.of(context)
                .pushNamed('/charge-registry') as bool?;

            if (chargeCadastrada != null && chargeCadastrada) {
              setState(() {
                loadCharge();
              });
            }
          },
          child: const Icon(Icons.add)),
    );
  }
}

class ChargeListItem extends StatelessWidget {
  final Charge charge;
  const ChargeListItem({Key? key, required this.charge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [Colors.lightGreen, Colors.blueAccent],
            ),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                topLeft: Radius.circular(20))),
        child: ListTile(
          leading: const Icon(
            Icons.person,
            size: 50,
            color: Colors.white,
          ),
          title: Text(charge.product.name,
              style: const TextStyle(color: Colors.white)),
          subtitle:
              const Text('Anonymous', style: TextStyle(color: Colors.white)),
          trailing: Text(
            '${charge.porcentCharged} %',
            style: const TextStyle(
                fontWeight: FontWeight.w500, fontSize: 15, color: Colors.white),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/charge-details', arguments: charge);
          },
        ));
  }
}
