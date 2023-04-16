import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:realtime_inovation_task/src/controllers/home_controller.dart';
import 'package:realtime_inovation_task/src/views/add_employee_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final Widget kFixHeight = const SizedBox(height: 8);

  final _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Employee List"),
          ),
          body: _homeController.employeeList.isNotEmpty
              ? Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: const Color(0xffF2F2F2),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Current Employees",
                          style: TextStyle(
                              color: Color(0xff1DA1F2),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    _homeController.currentEmployeesList.isNotEmpty
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  onDismissed: (direction) {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      _homeController.deleteEmployee(
                                          _homeController
                                                  .currentEmployeesList[index]
                                                  .employeeName ??
                                              "");
                                    }
                                  },
                                  background: Container(
                                    color: Colors.red,
                                  ),
                                  direction: DismissDirection.endToStart,
                                  key: UniqueKey(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _homeController
                                                  .currentEmployeesList[index]
                                                  .employeeName ??
                                              "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                        kFixHeight,
                                        Text(_homeController
                                                .currentEmployeesList[index]
                                                .role ??
                                            ""),
                                        kFixHeight,
                                        Text(
                                          "From ${DateFormat("dd MMM, yyyy").format(_homeController.currentEmployeesList[index].startDate!)}",
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount:
                                  _homeController.currentEmployeesList.length,
                            ),
                          )
                        : const Center(child: Text("No Data Found")),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: const Color(0xffF2F2F2),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Previous Employees",
                          style: TextStyle(
                              color: Color(0xff1DA1F2),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    _homeController.previousEmployeesList.isNotEmpty
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  onDismissed: (direction) {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      _homeController.deleteEmployee(
                                          _homeController
                                                  .previousEmployeesList[index]
                                                  .employeeName ??
                                              "");
                                    }
                                  },
                                  background: Container(color: Colors.red),
                                  key: UniqueKey(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _homeController
                                                  .previousEmployeesList[index]
                                                  .employeeName ??
                                              "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                        kFixHeight,
                                        Text(_homeController
                                                .previousEmployeesList[index]
                                                .role ??
                                            ""),
                                        kFixHeight,
                                        Text(
                                          "${DateFormat("dd MMM, yyyy").format(_homeController.previousEmployeesList[index].startDate!)} -> ${DateFormat("dd MMM, yyyy").format(_homeController.previousEmployeesList[index].endDate!)}",
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount:
                                  _homeController.previousEmployeesList.length,
                            ),
                          )
                        : const Center(
                            child: Text("No Data Found"),
                          ),
                  ],
                )
              : Center(child: Image.asset("assets/images/home_bg_image.png")),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEmployeeScreen(),
                ),
              );
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
