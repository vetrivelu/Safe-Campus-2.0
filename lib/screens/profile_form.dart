import 'package:flutter/material.dart';
import 'package:safecampus/controllers.dart/auth_controller.dart';
import 'package:safecampus/controllers.dart/dashboard_controller.dart';
import 'package:safecampus/controllers.dart/user_controller.dart';
import 'package:safecampus/firebase.dart';
import 'package:safecampus/models/user.dart';
import 'package:safecampus/widgets/custom_dropdown.dart';
import 'package:safecampus/widgets/custom_textbox.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  @override
  void initState() {
    super.initState();
    if (userController.user != null) {
      controller = userController.formController;
    } else {
      controller = UserFormController.plain();
    }
  }

  late UserFormController controller;

  List<DropdownMenuItem<UserType>>? get userTypeItems => UserType.values
      .map((e) => DropdownMenuItem(
          value: e,
          child: Text(
              e.toString().split('.').last.split(RegExp('(?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])')).map((e) => e.capitalizeFirst!).join(" "))))
      .toList();

  List<DropdownMenuItem<String?>>? get departmentItems =>
      dashboard.departments.map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userController.user != null ? "Edit Profile" : "Registration"),
        centerTitle: true,
      ),
      //=====================================Floating Action Button Here..............
      floatingActionButton: ElevatedButton(
        child: const Text("Submit"),
        onPressed: () {
          // userController.user = controller.usermodel;
          // userController.createUser();
          functions.httpsCallable('addAdmin').call({
            "email": "test@gmail.com",
            "password": "12345678",
            "user": controller.usermodel.toJson(),
          });
        },
      ),
      body: Form(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextBox(
                  controller: TextEditingController(text: auth.currentUser!.email), hintText: 'Your Email', labelText: 'Email', enabled: false),
              Table(
                columnWidths: const {
                  1: FlexColumnWidth(1.5),
                  2: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: CustomDropDown<UserType>(
                          selectedValue: controller.userType,
                          labelText: "User Type",
                          items: userTypeItems,
                          onChanged: (value) {
                            setState(() {
                              controller.userType = value ?? controller.userType;
                            });
                          },
                          hintText: '',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: CustomDropDown<String?>(
                            selectedValue: controller.department,
                            items: departmentItems,
                            labelText: "Department",
                            onChanged: (value) {
                              controller.department = value ?? controller.department;
                            }),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(),
              CustomTextBox(controller: controller.name, hintText: 'Enter your Name', labelText: 'Name', keyboardType: TextInputType.name),
              CustomTextBox(controller: controller.id, labelText: "ID", hintText: "Enter ID", keyboardType: TextInputType.text),
              CustomTextBox(
                  controller: controller.superId,
                  hintText: 'Enter your Passport or IC Number',
                  labelText: controller.userType == UserType.foreignStudent ? 'Passport Number' : 'IC Number',
                  keyboardType: TextInputType.name),
              Table(
                columnWidths: const {1: FlexColumnWidth(2)},
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child:
                            CustomTextBox(controller: controller.countryCode, labelText: "Code", hintText: "+60", keyboardType: TextInputType.text),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: CustomTextBox(
                            controller: controller.phoneNumber, labelText: "Phone", hintText: "Enter Phone Number", keyboardType: TextInputType.text),
                      ),
                    ],
                  ),
                ],
              ),
              CustomTextBox(
                controller: controller.address,
                hintText: 'Enter Address',
                labelText: "Address",
                keyboardType: TextInputType.multiline,
                maxLines: 6,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
