import 'dart:convert';

import 'fields.dart';

class Report{

   String? value;
   int? coverage;
   int? impressions;
   int? clicks;
   double? frequency;
   double? ctr;
   int? amountOfCosts;
   int? amountOfExpensesInTenge;
   double? costOf1000Coverages;
   double? leadCost;
   int? numberOfLeads;
   double? applicationConversion ;
   double? rate;

   Report(
      this.value,
      this.coverage,
      this.impressions,
      this.clicks,
      this.frequency,
      this.ctr,
      this.amountOfCosts,
      this.amountOfExpensesInTenge,
      this.costOf1000Coverages,
      this.leadCost,
      this.numberOfLeads,
      this.applicationConversion,
      this.rate);

   Report.fromJson(Map<String, dynamic> json)
       : value = json[ReportFields().value],
         coverage = jsonDecode(json[ReportFields().coverage]),
         impressions = jsonDecode(json[ReportFields().impressions]),
         clicks = jsonDecode(json[ReportFields().clicks]),
         frequency = jsonDecode(json[ReportFields().frequency]),
         ctr = jsonDecode(json[ReportFields().ctr]),
         amountOfCosts = jsonDecode(json[ReportFields().amountOfCosts]),
         amountOfExpensesInTenge = jsonDecode(json[ReportFields().coverage]),
         costOf1000Coverages = jsonDecode(json[ReportFields().costOf1000Coverages]),
         leadCost = jsonDecode(json[ReportFields().leadCost]),
         numberOfLeads = jsonDecode(json[ReportFields().numberOfLeads]),
         applicationConversion = jsonDecode(json[ReportFields().applicationConversion]),
         rate = jsonDecode(json[ReportFields().rate]);
}