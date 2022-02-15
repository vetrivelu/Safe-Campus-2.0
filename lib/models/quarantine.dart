class Quarantine {
  Quarantine({
    required this.inCampus,
    required this.blockNumber,
    required this.roomNumber,
    required this.address,
    required this.from,
    required this.to,
  });

  bool inCampus;
  String blockNumber;
  String roomNumber;
  String address;
  DateTime from;
  DateTime to;

  factory Quarantine.fromJson(Map<String, dynamic> json) => Quarantine(
        inCampus: json["inCampus"],
        blockNumber: json["blockNumber"],
        roomNumber: json["roomNumber"],
        address: json["address"],
        from: DateTime.parse(json["from"]),
        to: DateTime.parse(json["to"]),
      );

  Map<String, dynamic> toJson() => {
        "inCampus": inCampus,
        "blockNumber": blockNumber,
        "roomNumber": roomNumber,
        "address": address,
        "from": from.toIso8601String(),
        "to": to.toIso8601String(),
      };
}
