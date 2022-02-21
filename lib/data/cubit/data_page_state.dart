part of 'data_page_cubit.dart';
abstract class DataPageState{}

class DataPageEmpty extends DataPageState{}
class DataPageLoading extends DataPageState{}
class DataPageLoaded extends DataPageState{
  List<Report> reports;
  DataPageLoaded({required this.reports});
}
class DataPageError extends DataPageState{
  String message;
  DataPageError({required this.message});
}

