import 'dart:developer';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sheet_app/data/cubit/data_page_cubit.dart';
import 'package:google_sheet_app/data/model/report.dart';
import 'package:google_sheet_app/presentation/widgets/error_page.dart';
import 'package:google_sheet_app/presentation/widgets/list_of_list_tiles.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {

int selectedIndex = 0;
String? selectedDay = "";

DropdownButtonFormField<String> androidDropdown(List<Report> reports) {
  selectedDay=timeConverter(reports[0].value);
  List<DropdownMenuItem<String>> dropdownItems = [];
  for (Report currency in reports) {
    var newItem = DropdownMenuItem(
      child: Text('${timeConverter(currency.value)}'),
      value: timeConverter(currency.value),
    );
    dropdownItems.add(newItem);
  }

  return DropdownButtonFormField<String>(
    icon: const Icon(
      Icons.arrow_drop_down,
      color: Colors.white,
      size: 30,
    ),
    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      filled: true,
      fillColor: Colors.blueAccent,
    ),
    dropdownColor: Colors.blueAccent,
    value: selectedDay,
    items: dropdownItems,
    onChanged: (value) {
      setState(() {
        selectedDay = value;
        for(Report r in reports){
          if(timeConverter(r.value) == value){
            selectedIndex = reports.indexOf(r);
            break;
          }
        }
        log("SELECTED ITEM:::::::::: $selectedIndex");
      });
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Отчет Hirint за Январь', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: BlocConsumer<DataPageCubit,DataPageState>(
        listener: (context,state){

        },
        builder:(context,state){
          if(state is DataPageEmpty){
            return const Center(
              child: Text('No reports to show'),
            );
          }
          if(state is DataPageLoading){
            return const Center(
                child: CircularProgressIndicator(
                color: Colors.purple,
            ),
          );
          }
          if(state is DataPageLoaded){
            Report report = state.reports[selectedIndex];
            return Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                    child: androidDropdown(state.reports)
                ),
                ListOfListTile(report: report)
              ],
            );
          }
          if(state is DataPageError) {
            return ErrorPage(error: state.message, onPressed: (){
              BlocProvider.of<DataPageCubit>(context).getReports();
            });
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DataPageCubit>(context).getReports();
  }


  String? timeConverter(String? days){
    try{
      int day = int.parse(days!)-2;
      DateTime firstDate = DateTime(1900);
      DateTime normalDate = firstDate.add(Duration(days: day));
      String formattedDate = formatDate(normalDate,[dd, '.', mm, '.', yyyy]);
      return formattedDate;
    }catch(e){
      return days;
    }
  }
}


