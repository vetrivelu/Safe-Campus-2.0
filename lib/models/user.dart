import 'contact.dart';
import 'quarantine.dart';

class UserModel {
  UserModel({
    required this.name,
    required this.department,
    required this.id,
    required this.superId,
    required this.address,
    required this.uid,
    required this.groupid,
    required this.deviceid,
    required this.userType,
    required this.countryCode,
    required this.phoneNumber,
    this.quarantine,
    required this.contacts,
  });

  String name;
  String department;
  String id;
  String superId;
  String uid;
  String groupid;
  String deviceid;
  String address;
  String countryCode;
  String phoneNumber;
  UserType userType;
  Quarantine? quarantine;
  List<Contact> contacts;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        department: json["department"],
        id: json["id"],
        superId: json["superId"],
        uid: json["uid"],
        groupid: json["groupid"],
        deviceid: json["deviceid"],
        quarantine: json["quarantine"] != null ? Quarantine.fromJson(json["quarantine"]) : null,
        contacts: List<Contact>.from(json["contacts"].map((x) => Contact.fromJson(x))),
        userType: UserType.values.elementAt(json["userType"]),
        address: json["address"],
        countryCode: json["countryCode"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "countryCode": countryCode,
        "name": name,
        "department": department,
        "id": id,
        "superId": superId,
        "uid": uid,
        "groupid": groupid,
        "deviceid": deviceid,
        "quarantine": quarantine?.toJson(),
        "contacts": List<dynamic>.from(contacts.map((x) => x.toJson())),
        "userType": userType.index,
        "address": address,
      };
}

enum UserType { localStudent, foreignStudent, staff }
