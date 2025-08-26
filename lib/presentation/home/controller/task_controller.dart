
import 'package:get/get.dart';
import 'package:todo_app/data/models/todo_model.dart';

class TaskController  extends GetxController{
  var selectedStatus=TaskStatus.all.obs;
  void ChangeStatus(TaskStatus status){
    selectedStatus.value=status;
  }
}