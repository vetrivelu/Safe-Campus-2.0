import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safecampus/constants/themeconstants.dart';
import 'package:safecampus/controllers.dart/auth_controller.dart';
import 'package:safecampus/controllers.dart/dashboard_controller.dart';
import 'package:safecampus/widgets/network_image.dart';
import 'package:safecampus/widgets/tile_home.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.black),
                ),
                content: const Text('Are you sure you wish to logout?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      auth.signOut();
                      Navigator.pop(context, 'OK');
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(
            Icons.logout,
            color: Color(0xFFED392D),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(
                Icons.circle_notifications_outlined,
                size: 30,
              ),
              color: const Color(0xFFED392D),
              onPressed: () {
                // Get.to(()=>NotificationPage());
              },
            ),
          )
        ],
        title: Padding(
          padding: const EdgeInsets.only(left: 48, right: 56, top: 48, bottom: 48),
          child: Image.asset(
            'assets/images/iukl_logo.png',
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: GetBuilder(
                init: dashboard,
                builder: (context) {
                  return CarouselSlider(
                    options: CarouselOptions(height: 150, autoPlay: true, aspectRatio: 16 / 9),
                    items: dashboard.carouselItems.map((element) => CustomNetworkImage(url: element)).toList(),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
                child: Table(
              columnWidths: const {1: FlexColumnWidth(1), 2: FlexColumnWidth(3)},
              children: const [
                TableRow(
                  children: [
                    PaddedText("Beacon Status", style: TextStyle(fontWeight: FontWeight.bold)),
                    PaddedText("Active"),
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText("Current Location", style: TextStyle(fontWeight: FontWeight.bold)),
                    PaddedText("B Hall (GateWay)"),
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText("Current Location", style: TextStyle(fontWeight: FontWeight.bold)),
                    PaddedText("B Hall (GateWay)"),
                  ],
                ),
              ],
            )),
          ),
          const Divider(),
          PaddedText("Menu", style: getText(context).subtitle1!.copyWith(fontWeight: FontWeight.bold)),
          Wrap(
            direction: Axis.horizontal,
            children: [
              Tile(
                title: 'Status',
                image: 'assets/images/high-fever-512x512-1833393.png',
              ),
              Tile(
                title: 'History',
                image: 'assets/images/ContactHistory.png',
              ),
              Tile(
                title: 'Solitary',
                image: 'assets/images/virus-protection-512x512-1833388.png',
              ),
              Tile(
                title: 'Complaint',
                image: 'assets/images/whistle blower.png',
              ),
              Tile(
                title: 'Bulletin',
                image: 'assets/images/announcement.png',
              ),
              Tile(
                title: 'Profile',
                image: 'assets/images/profile.png',
              ),
              Tile(
                title: 'Assesments',
                image: 'assets/images/profile.png',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PaddedText extends StatelessWidget {
  const PaddedText(this.text, {Key? key, this.style}) : super(key: key);

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
