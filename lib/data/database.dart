import 'package:hive_flutter/hive_flutter.dart';
class toDoDatabase{
  List toDOList =[];
  final _mybox = Hive.box('mybox');

  void createInitialData(){
    toDOList=[
      ["Exercise", false],
    ];
  }

  void loadData(){
    toDOList = _mybox.get("TODOLIST");
  }

  void updateDatabase(){
    _mybox.put("TODOLIST", toDOList);
  }
}