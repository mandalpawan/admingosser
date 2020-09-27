


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

String filePath;

Future<String> get _localPath async {
  final directory = await getApplicationSupportDirectory();
  return directory.absolute.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  filePath = '$path/data.csv';
  return File('$path/data.csv').create();
}



getCsv() async {

  List<List<dynamic>> rows = List<List<dynamic>>();

  var cloud = await Firestore.instance
      .collection("orders")
      .document()
      .get();

  print(cloud.data.length);
  rows.add([
    "name"
  ]);

  if (cloud.data != null) {
    for (int i = 0; i < cloud.data["collected"].length; i++) {
      List<dynamic> row = List<dynamic>();
      row.add(cloud.data["collected"][i]["name"]);
      rows.add(row);
    }

    File f = await _localFile;

    String csv = const ListToCsvConverter().convert(rows);
    f.writeAsString(csv);
    print(csv);
  }
  print("hello");
}