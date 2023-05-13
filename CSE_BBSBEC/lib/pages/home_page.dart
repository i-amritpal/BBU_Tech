import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../data/data_model.dart';
import '../utils/dialog_box.dart';
import '../utils/todo_tile.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //reference to Hive Box
  final _myBox = Hive.box('myBox');

  //instance of data model
  ToDoDataModel db = ToDoDataModel();

  @override
  void initState() {
    //if this app is opened for the first time
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      //there already exist data
      db.loadData();
    }
    super.initState();
  }

  //text Controller
  final _controller = TextEditingController();

  //checkBox Function
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  //save new task
  void saveNewTask() {
    setState(() {
      _controller.text.trimLeft() == ''
          ? ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Add some Notification-Task!'),
                action: SnackBarAction(
                    label: 'Ok',
                    onPressed: () {
                      createNewTask();
                    }),
              ),
            )
          : db.toDoList.add([_controller.text, false]);
      db.updateDatabase();
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  //create New Task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () {
              Navigator.of(context).pop();
              _controller.clear();
            },
          );
        });
  }

  //delete Task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        // backgroundColor: Colors.purple,
        title: const Text('Notifications'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[Colors.purple, Colors.blue]
            )
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: createNewTask,
        enableFeedback: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: const Icon(Icons.add),
      ),
      body: db.toDoList.isNotEmpty
          ? ListView.builder(
              padding:
                  const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
              itemBuilder: (context, index) {
                return ToDoTile(
                  taskName: db.toDoList[index][0],
                  taskStatus: db.toDoList[index][1],
                  onChanged: (value) => checkBoxChanged(value, index),
                  deleteTask: (context) => deleteTask(index),
                );
              },
              itemCount: db.toDoList.length,
            )
          : Center(
              child: Container(
                height: 550,
                width: 450,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.linearToSrgbGamma(),
                    image: AssetImage('assets/Nothing.png'),
                  ),
                ),
              ),
            ),
    );
  }
}