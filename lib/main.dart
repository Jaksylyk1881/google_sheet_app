import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sheet_app/data/cubit/data_page_cubit.dart';
import 'package:google_sheet_app/data/report_sheets_api.dart';
import 'package:google_sheet_app/presentation/screens/data_page.dart';


void main()  {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DataPageCubit>(create: (context)=>DataPageCubit())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const DataPage(),
      ),
    );
  }
}
