import 'package:flutter/material.dart';
import 'package:todo/data/database.dart';
import 'package:todo/dialog_box.dart';
import 'package:todo/todolist.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  toDoDatabase db = toDoDatabase();
  final _mybox = Hive.box('mybox');
  final _controller = TextEditingController();
  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDOList[index][1]=!db.toDOList[index][1];
    });
    db.updateDatabase();
  }

  @override
  void initState() {
    // TODO: implement initState
    if(_mybox.get("TODOLIST")==null){
      db.createInitialData();
    }
    else{
      db.loadData();
    }
    super.initState();
  }

  void saveNewTask(){
    setState(() {
      db.toDOList.add([_controller.text, false]);
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void createTask(){
    showDialog(context: context, builder: (context){
      return DialogBox(controller: _controller, onSave: saveNewTask, onCancel: ()=>Navigator.of(context).pop(),);
    });
  }

  void deleteTask(int index){
    setState(() {
      db.toDOList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text("TODO", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          createTask();
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDOList.length,
        itemBuilder: (BuildContext context, int index) {
          return Todolist(
            taskName: db.toDOList[index][0],
            isCompleted: db.toDOList[index][1],
            changed: (value)=> checkBoxChanged(value, index),
            deleteFunction: (context)=> deleteTask(index),
          );
        },
      ),
    );
  }
}
