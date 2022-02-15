class Contact {
  Contact({
    required this.uid,
    this.fcm,
    required this.time,
    required this.name,
    required this.location,
    required this.gateway,
  });

  String uid;
  String? fcm;
  DateTime time;
  String name;
  String location;
  String gateway;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        uid: json["uid"],
        fcm: json["fcm"],
        time: DateTime.parse(json["time"]),
        name: json["name"],
        location: json["location"],
        gateway: json["gateway"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "fcm": fcm,
        "time": time.toIso8601String(),
        "name": name,
        "location": location,
        "gateway": gateway,
      };
}
