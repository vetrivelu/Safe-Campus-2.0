import 'package:get/get.dart';

import '../firebase.dart';

class Dashboard extends GetxController {
  static Dashboard instance = Get.find();
  List<dynamic> carouselItems = [];
  List<dynamic> departments = [];

  @override
  onInit() {
    loadCaruosel();
    super.onInit();
    loadDepartments();
  }

  loadCaruosel() {
    firestore.collection('dashboard').doc('Carousel').snapshots().listen((snapshot) {
      var urls = snapshot.data()?["imageUrl"];
      carouselItems = urls;
      update();
    });
  }

  loadDepartments() {
    firestore.collection('dashboard').doc('Departments').get().then((snapshot) {
      if (snapshot.exists) {
        departments = snapshot.data()!.values.toList();
      }
      update();
    });
  }
}

Dashboard dashboard = Dashboard.instance;
