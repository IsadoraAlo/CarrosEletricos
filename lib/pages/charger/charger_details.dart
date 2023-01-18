import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:global_solution/models/charge.dart';
import 'package:intl/intl.dart';

import '../../components/navigation_drawer.dart';
import '../../utils/product_color.dart';

class ChargerDetailPage extends StatelessWidget {
  const ChargerDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final charge = ModalRoute.of(context)!.settings.arguments as Charge;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          centerTitle: true,
          elevation: 0.0,
          title: Text(charge.product.name,
              style: TextStyle(
                  color: ProductColor.mapColors[charge.product.color],
                  fontWeight: FontWeight.w800)),
          iconTheme: IconThemeData(
              color: ProductColor.mapColors[charge.product.color]),
        ),
        drawer: const NavigationDrawer(),
        body: Center(
          child: Column(children: [
            SizedBox(
                width: 300,
                height: 300,
                child: PieChart(PieChartData(
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 0,
                    sections: getSections(charge)))),
            Text('${charge.porcentCharged} % Charged',
                style: TextStyle(
                    color: ProductColor.mapColors[charge.product.color],
                    fontWeight: FontWeight.w800)),
            const Divider(
              color: Colors.transparent,
            ),
            Text('The estimate for the next recharge is on the day',
                style: TextStyle(
                    color: ProductColor.mapColors[charge.product.color],
                    fontWeight: FontWeight.w800)),
            const Divider(
              color: Colors.transparent,
            ),
            Text(estimatedDate(charge),
                style: TextStyle(
                    color: ProductColor.mapColors[charge.product.color],
                    fontSize: 40,
                    fontWeight: FontWeight.w800)),
          ]),
        ));
  }

  String estimatedDate(Charge charge) {
    int lastCharge = (int.parse(charge.porcentCharged));
    DateTime lastChargeDate = charge.date;
    DateFormat('dd/MM/yyyy').format(lastChargeDate);
    DateTime newDate;

    if (lastCharge >= 85) {
      newDate = lastChargeDate.add(const Duration(days: 30));
      return DateFormat('dd/MM/yyyy').format(newDate);
    } else if (lastCharge < 85 && lastCharge >= 70) {
      newDate = lastChargeDate.add(const Duration(days: 25));
      return DateFormat('dd/MM/yyyy').format(newDate);
    } else if (lastCharge < 70 && lastCharge >= 55) {
      newDate = lastChargeDate.add(const Duration(days: 20));
      return DateFormat('dd/MM/yyyy').format(newDate);
    } else if (lastCharge < 55 && lastCharge >= 40) {
      newDate = lastChargeDate.add(const Duration(days: 15));
      return DateFormat('dd/MM/yyyy').format(newDate);
    } else if (lastCharge < 40 && lastCharge >= 25) {
      newDate = lastChargeDate.add(const Duration(days: 10));
      return DateFormat('dd/MM/yyyy').format(newDate);
    } else if (lastCharge < 25) {
      newDate = lastChargeDate.add(const Duration(days: 5));
      return DateFormat('dd/MM/yyyy').format(newDate);
    }
    return lastChargeDate.toString();
  }

  List<PieChartSectionData> getSections(Charge charge) {
    double charged = (double.parse(charge.porcentCharged));
    double nonCharged = 100 - charged;
    return List.generate(2, (i) {
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: ProductColor.mapColors[charge.product.color],
            value: charged,
            radius: 100,
            title: '',
          );
        case 1:
          return PieChartSectionData(
            color: const Color.fromARGB(255, 202, 202, 202),
            value: nonCharged,
            radius: 100,
            title: '',
          );
        default:
          throw Error();
      }
    });
  }
}
