import 'package:hive/hive.dart';

class ToDoDataModel {
  List toDoList = [];

  //reference to Hive Box
  final _myBox = Hive.box('myBox');

  //run this method is this is the first time ever opening this app
  void createInitialData() {
    toDoList = [
      ['Welcome 👋', false],
      ['Add a Notification!', false],
    ];
  }

  //load data from the database
  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  //update database
  void updateDatabase() {
    _myBox.put('TODOLIST', toDoList);
  }
}