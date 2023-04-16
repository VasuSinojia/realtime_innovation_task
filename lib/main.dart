import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:realtime_inovation_task/src/models/employee_model.dart';
import 'package:realtime_inovation_task/src/views/home_screen.dart';

import 'common/config/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory? dir = await getExternalStorageDirectory();
  Hive.init(dir!.path);

  Hive.registerAdapter(EmployeeModelAdapter());
  await Hive.openBox(Config.sharedInstance.employeeBox);

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
