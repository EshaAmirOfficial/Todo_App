

import 'package:get/get.dart';

class CreateTaskController extends GetxController {
  var selectedPriority = "".obs;
  var selectedCategory = "".obs;

  List<String> priorities = ["High", "Medium", "Low"];
  List<String> categories = ["Work", "Personal", "Shopping"];

  void selectPriority(String value) {
    selectedPriority.value = value;
  }

  void selectCategory(String value) {
    selectedCategory.value = value;
  }
}
