import 'package:hive/hive.dart';

part 'employee_model.g.dart';

@HiveType(typeId: 1)
class EmployeeModel extends HiveObject {
  @HiveField(0)
  String? employeeName;

  @HiveField(1)
  String? role;

  @HiveField(2)
  DateTime? startDate;

  @HiveField(3)
  DateTime? endDate;

  EmployeeModel({this.employeeName, this.role, this.startDate, this.endDate});
}
