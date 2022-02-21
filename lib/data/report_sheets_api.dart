import 'dart:developer';

import 'package:google_sheet_app/data/model/report.dart';
import 'package:gsheets/gsheets.dart';

class ReportSheetsApi{
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "gsheets-341908",
  "private_key_id": "ff860e1db1fe55db06a24771be81eb987ecf3442",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCmTEOx0N7ccxBD\nnpS5I9+P8+z7reAyrd5sETlnve+fro/YEA+Ao3KRmVHBBnTqw251LUZFChFZrA2i\nRBna0ksg2EW41Bp+rKIVwgDVCxRT4iK10esAdIG07WqiV3ZMVR1PrQ+rEsgiaNNW\n1W3uLnrR0/trj0BjZvhUN6caXB8CJh7CaLkb+QwxkZb/bSxsRd912LR80zHiBJ07\nraUd6yvHbpBTmV6iPChqEUAcHeAx9kQfVJJYl90vOk8IdkJeNOo/yUfDOJkNuOpQ\nXSQkj1YT7uLt4JESLEgtPc8OCED+ggUo2FZ5NUHZFg6eZ9DAeOqyGBq36/JKI8Ej\nEbOyvFnbAgMBAAECggEATbYO3k3mjyr/+zFke339j3YkFNqEjfo9GdAUvNt/2mWH\nF6ctr2Xx+IMmtqaPRVOtTvmowEN7pyVlO6JKWLzz2bXnIv+PIAoJNlSx8dybE7X1\nlXSytkQ7hrJ5pcJsaDBQIbcUPtPojVfiBs528BptT5eZgoJvSuRIAIb/QiyxWt12\nTUTNqB/TJylM/TpFTIdfFQ8rN0jA+9pgnxijuz9pH6Brt2syndzvlTuGRe26BG2R\nkk4UsSgLNiuP6PoRJLdSLDqg56+OAuN8LNAtcGjLpJ6FNfvV6VDkh/Tg4g/ZFkmO\ns4LuMtxKx/DwGJfCJZg7vVw/QIGu/pMco/Lm7RrMYQKBgQDoIY83LN+XcVj7O09y\n0jQ69jurN43QAvKkGTqd9nz/M/OPVQI3RZcJDwN4CANQ+XMru08UgIWnVbI9cFa9\nJWRdXIKoBrJCBvzM555erQ6qacGVKwH7euw+oA+HpXfCpnyOOSd5swLKHNP7ESza\nJcu0gEdagcEg3Py66U/fsji2oQKBgQC3ZcNJIGJw1bM4zZbDh6X5Elzdnajraykf\nr8xzRmqJ/PaClx90wf9+GqRtok/h3HYnzTomQHPoZsBLkW1/K/rJDTcCFhrWNr/M\n+dWcP2P7XFHGlCNItzABhQtDpKjs//DcEVF2iELHeo7wABoAZvkEYMj3tZjoHnjW\nMateUJ8K+wKBgQCkgtQquESl4ZC8TCZcK5kUiFl1WGPKnaw0nCSsunmPq9PbKtXt\nMgZ+RwOgV51yD7eNsKu0zfjqxJMTc8AlQJDGkb+PMV+355fV5/iXBHK2V0j4XIiF\nH3K6V1lqOtyLOM5hRSQy3akGcDPTZTKyT8L0Y00uWXLzxWnfVWZkFLyYwQKBgBSp\nyo76rxy3dzH3N/1f0zt07jGqCdY8hK2lSQvT6z0Q21VrYYfuM7MpnU0c9JMmG8nw\nPZUBvg15RkE9aXDiq6brbj817mAkWwflPkQUgFdZ13zgQ/l1altBejts2fuZ+rFQ\n4jTQtXV0QZaY7FUPRQ9ROFNwioHcrRC1F/HQc5rxAoGBANFDiBpZTuP5Vh7p2Mki\ndG927FdTeaMxoIda+gReXwzSK+hAHVnI9U8kFjUV0BI+jEQmSMpMoDZv68S00Y6W\nIQLUJJgsIGEtUq8I6hnJmR3O76V5CViuOoGxZ9ZA1SiYfygDRrBk8puJNJHY0jeA\noHdcwohB3ZcjOI/B+P3Ozq4c\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-341908.iam.gserviceaccount.com",
  "client_id": "108221757366623899112",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-341908.iam.gserviceaccount.com"
}

  ''';
  static final _spreadSheetId = '1JCw1eqWGQOETb8mE4f6aUOb5gKxfY0bD2_ZDD4WVxes';
  static final _gSheets = GSheets(_credentials);
  static Worksheet? _reportForJanuary;

  static Future init() async{
    final spreadSheet = await _gSheets.spreadsheet(_spreadSheetId);
    _reportForJanuary = await _getWorkSheet(spreadSheet,title:'FB_янв');
  }

  static Future<Worksheet?> _getWorkSheet(Spreadsheet spreadSheet, {required String title}) async {
    try{
      return spreadSheet.worksheetByTitle(title);
    }catch(e){
      log('ERROR:::::   e');
      return spreadSheet.addWorksheet(title);
    }
  }

   Future<List<Report>> getAll() async{
    if(_reportForJanuary ==null) return <Report> [];
    final reports = await _reportForJanuary!.values.map.allColumns();
    return reports == null ? <Report>[] : reports.map(Report.fromJson).toList();
  }

}