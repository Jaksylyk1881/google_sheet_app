import 'package:flutter/material.dart';
import 'package:google_sheet_app/data/model/report.dart';

import '../constants.dart';

class ListOfListTile extends StatelessWidget {
  const ListOfListTile({
    Key? key,
    required this.report,
  }) : super(key: key);

  final Report report;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: ListTile.divideTiles( //          <-- ListTile.divideTiles
              context: context,
              tiles: [
                ListTile(
                  title: const Text('Охват',style: kTextStyleLabel),
                  trailing: Text('${report.coverage}',style:kTextStyleContent),
                ),
                ListTile(
                  title: const Text('Показы',style: kTextStyleLabel),
                  trailing: Text('${report.impressions}',style:kTextStyleContent),
                ),
                ListTile(
                  title: const Text('Клики',style: kTextStyleLabel),
                  trailing: Text('${report.clicks}',style:kTextStyleContent),
                ),
                ListTile(
                  title: const Text('Частота',style: kTextStyleLabel),
                  trailing: Text('${report.frequency?.toStringAsFixed(1)}',style:kTextStyleContent),
                ),
                ListTile(
                  title: const Text('CTR',style: kTextStyleLabel),
                  trailing: Text('${((report.ctr)!*100).toStringAsFixed(2)}%',style:kTextStyleContent),
                ),
                ListTile(
                  title: const Text('Сумма затрат',style: kTextStyleLabel),
                  trailing: Text('${report.amountOfCosts}',style:kTextStyleContent),
                ),
                ListTile(
                  title: const Text('Сумма затрат в тенге',style: kTextStyleLabel),
                  trailing: Text('${report.amountOfExpensesInTenge}',style:kTextStyleContent),
                ),
                ListTile(
                  title: const Text('Стоимость 1000 охватов',style: kTextStyleLabel),
                  trailing: Text('${report.costOf1000Coverages?.toStringAsFixed(0)}',style:kTextStyleContent),
                ),
                ListTile(
                  title: const Text('Стоимость лида',style: kTextStyleLabel),
                  trailing: Text('${report.leadCost?.toStringAsFixed(0)}',style:kTextStyleContent),
                ),
                ListTile(
                  title: const Text('Кол-во лидов',style: kTextStyleLabel),
                  trailing: Text('${report.numberOfLeads}',style:kTextStyleContent),
                ),
                ListTile(
                  title: const Text('Конверсия в заявку',style: kTextStyleLabel),
                  trailing: Text('${((report.applicationConversion)!*100).toStringAsFixed(1)}%',style:kTextStyleContent),
                ),
                ListTile(
                  title: const Text('Курс валюты',style: kTextStyleLabel),
                  trailing: Text('${report.rate?.toStringAsFixed(1)}',style:kTextStyleContent),
                ),
              ]
          ).toList(),
        ),
      ),
    );
  }
}