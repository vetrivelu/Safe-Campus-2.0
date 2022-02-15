import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:safecampus/controllers.dart/dashboard_controller.dart';
import 'package:safecampus/firebase.dart';
import 'package:safecampus/models/contact.dart';
import 'package:safecampus/models/quarantine.dart';
import 'package:safecampus/models/response.dart' as response;
import 'package:safecampus/models/user.dart';

import 'auth_controller.dart';

final users = firestore.collection("Users");

class UserController extends GetxController {
  UserModel? user;
  static UserController instance = Get.find();
  String? get id => user != null ? user!.id : null;
  String? get name => user != null ? user!.name : null;
  String? get department => user != null ? user!.department : null;
  String? get superId => user != null ? user!.superId : null;
  String? get uid => user != null ? user!.uid : null;
  String? get groupid => user != null ? user!.groupid : null;
  String? get deviceid => user != null ? user!.deviceid : null;
  String? get address => user != null ? user!.address : null;
  String? get countryCode => user != null ? user!.address : null;
  String? get phoneNumber => user != null ? user!.address : null;
  UserType? get userType => user != null ? user!.userType : null;
  Quarantine? get quarantine => user != null ? user!.quarantine : null;
  List<Contact> get contacts => user != null ? user!.contacts : [];

  UserFormController get formController => UserFormController(
        name: TextEditingController(text: name),
        department: department,
        id: TextEditingController(text: id),
        superId: TextEditingController(text: superId),
        groupid: TextEditingController(text: groupid),
        deviceid: TextEditingController(text: deviceid),
        userType: userType ?? UserType.localStudent,
        address: TextEditingController(text: address),
        countryCode: TextEditingController(text: countryCode),
        phoneNumber: TextEditingController(text: phoneNumber),
      );

  @override
  // ignore: unnecessary_overrides
  onInit() {
    loadContacts();
    loadAssessments();
    listenProfile();
    super.onInit();
  }

  updateUser() {}

  listenProfile() {
    users.doc(auth.uid).snapshots().listen((snapshot) {
      if (snapshot.exists) {
        user = UserModel.fromJson(snapshot.data()!);
      } else {
        user = null;
      }
      update();
    });
  }

  createUser() async {
    if (user != null) {
      return users.doc(uid).set(user!.toJson()).then((value) {
        // update();
        return response.Response.success("message");
      }).onError((error, stackTrace) => response.Response.error(error));
    }
    return response.Response.error("Null user can't be added");
  }

  loadContacts() {}
  loadAssessments() {}
}

UserController userController = UserController.instance;

class UserFormController {
  final TextEditingController name;

  final TextEditingController id;
  final TextEditingController superId;
  final TextEditingController groupid;
  final TextEditingController deviceid;
  final TextEditingController address;
  final TextEditingController countryCode;
  final TextEditingController phoneNumber;

  UserType userType;
  String? department;
  String? uid;

  UserFormController(
      {required this.name,
      required this.id,
      required this.superId,
      required this.groupid,
      required this.deviceid,
      this.userType = UserType.localStudent,
      this.department,
      this.uid,
      required this.address,
      required this.countryCode,
      required this.phoneNumber});

  factory UserFormController.plain() => UserFormController(
        name: TextEditingController(),
        department: dashboard.departments.isEmpty ? null : dashboard.departments.first,
        deviceid: TextEditingController(),
        groupid: TextEditingController(),
        id: TextEditingController(),
        superId: TextEditingController(),
        address: TextEditingController(),
        countryCode: TextEditingController(),
        phoneNumber: TextEditingController(),
      );

  UserModel get usermodel => UserModel(
        name: name.text,
        department: department!,
        id: id.text,
        superId: superId.text,
        uid: auth.uid!,
        groupid: groupid.text,
        deviceid: deviceid.text,
        userType: userType,
        contacts: [],
        address: address.text,
        countryCode: countryCode.text,
        phoneNumber: phoneNumber.text,
      );
}
