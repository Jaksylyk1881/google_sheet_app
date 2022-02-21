import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sheet_app/data/model/report.dart';

import '../report_sheets_api.dart';

part 'data_page_state.dart';
class DataPageCubit extends Cubit<DataPageState>{
  DataPageCubit() : super(DataPageEmpty());
  List<Report> _reports = [];


  Future getReports() async{
    try{
      emit(DataPageLoading());
      await ReportSheetsApi.init();
      log("FETCHING DATA...........");
      final reports = await ReportSheetsApi().getAll();
      _reports = reports;
      for(Report a in _reports){
        log(" ${a.coverage},${a.impressions},${a.clicks},${a.frequency}${a.ctr},${a.amountOfCosts},${a.amountOfExpensesInTenge},${a.costOf1000Coverages},${a.leadCost},${a.numberOfLeads},${a.applicationConversion} ,${a.rate}");
      }
      emit(DataPageLoaded(reports: _reports));
    }catch(e){
      emit(DataPageError(message: '$e'));
    }




  }

}