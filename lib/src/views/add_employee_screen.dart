import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:realtime_inovation_task/common/widgets/common_textfield.dart';
import 'package:realtime_inovation_task/src/controllers/home_controller.dart';
import 'package:realtime_inovation_task/src/models/employee_model.dart';

class AddEmployeeScreen extends StatelessWidget {
  AddEmployeeScreen({Key? key}) : super(key: key);

  //Mark: - Class Variables
  final employeeNameController = TextEditingController();
  final selectRoleController = TextEditingController();
  final fromDateController = TextEditingController(text: "Today");
  final toDateController = TextEditingController();

  final List<String> roleList = [
    "Product Designer",
    "Flutter Developer",
    "QA Tester",
    "Product Owner",
  ];

  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  final Widget kFixHeight = const SizedBox(height: 12);

  final HomeController homeController = Get.put(HomeController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Employee Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              kFixHeight,
              CommonTextField(
                controller: employeeNameController,
                labelText: "Employee name",
                prefixIcon: const Icon(Icons.account_circle),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter employee name";
                  }
                  return null;
                },
              ),
              kFixHeight,
              CommonTextField(
                onTap: () {
                  showCustomBottomSheet(context);
                },
                readOnly: true,
                controller: selectRoleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please select role";
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.business_center),
                suffixIcon: const Icon(Icons.arrow_drop_down),
                labelText: "Select Role",
              ),
              kFixHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CommonTextField(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: selectedFromDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050),
                        ).then(
                          (value) {
                            if (value == null) {
                              return;
                            }
                            fromDateController.text =
                                DateFormat("dd MMM yyyy").format(value);
                            selectedFromDate = value;
                          },
                        );
                      },
                      readOnly: true,
                      controller: fromDateController,
                      hintText: "No Date",
                      prefixIcon: const Icon(Icons.calendar_month),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0),
                    child: Icon(Icons.arrow_right_alt),
                  ),
                  Expanded(
                    child: CommonTextField(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: selectedToDate,
                          firstDate: fromDateController.text == "Today"
                              ? DateTime.now()
                              : selectedFromDate,
                          lastDate: DateTime.now(),
                        ).then(
                          (value) {
                            if (value == null) {
                              return;
                            }
                            toDateController.text =
                                DateFormat("dd MMM yyyy").format(value);
                            selectedToDate = value;
                          },
                        );
                      },
                      readOnly: true,
                      controller: toDateController,
                      hintText: "No Date",
                      prefixIcon: const Icon(Icons.calendar_month),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomSheet: SizedBox(
        height: 70,
        child: Row(
          children: [
            const Expanded(
              child: SizedBox(),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: const Color(0xffEDF8FF),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Color(0xff1DA1F2)),
              ),
            ),
            const SizedBox(width: 10),
            MaterialButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  EmployeeModel employee = EmployeeModel(
                    employeeName: employeeNameController.text,
                    role: selectRoleController.text,
                    startDate: fromDateController.text == "Today"
                        ? DateTime.now()
                        : selectedFromDate,
                    endDate: toDateController.text.isEmpty
                        ? null
                        : selectedToDate,
                  );
                  homeController.addEmployee(employee);
                  Navigator.pop(context);
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: const Color(0xff1DA1F2),
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            roleList.length,
            (index) => MaterialButton(
              onPressed: () {
                selectRoleController.text = roleList[index];
                Navigator.pop(context);
              },
              child: Text(roleList[index]),
            ),
          ),
        );
      },
    );
  }
}
