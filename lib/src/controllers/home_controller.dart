import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:realtime_inovation_task/common/config/config.dart';

import '../models/employee_model.dart';

class HomeController extends GetxController {
  var employeeList = <EmployeeModel>[].obs;
  var currentEmployeesList = <EmployeeModel>[].obs;
  var previousEmployeesList = <EmployeeModel>[].obs;

  addEmployee(EmployeeModel employee) async {
    employeeList.add(employee);

    Box box = await Hive.openBox(Config.sharedInstance.employeeBox);
    box
        .put(Config.sharedInstance.employeeList, employeeList)
        .then((value) => getEmployeeData());
  }

  getEmployeeData() {
    final box = Hive.box(Config.sharedInstance.employeeBox);
    if (box.containsKey(Config.sharedInstance.employeeList)) {
      employeeList.value =
          List<EmployeeModel>.from(box.get(Config.sharedInstance.employeeList));
    }

    separateEmployees();
  }

  separateEmployees() {
    currentEmployeesList.value =
        employeeList.where((element) => element.endDate == null).toList();
    previousEmployeesList.value =
        employeeList.where((p0) => p0.endDate != null).toList();
  }

  deleteEmployee(String employeeName) async {
    employeeList.removeWhere((element) => element.employeeName == employeeName);

    Box box = await Hive.openBox(Config.sharedInstance.employeeBox);
    box
        .put(Config.sharedInstance.employeeList, employeeList)
        .then((value) => getEmployeeData());
  }

  @override
  void onReady() {
    getEmployeeData();
    super.onReady();
  }
}
