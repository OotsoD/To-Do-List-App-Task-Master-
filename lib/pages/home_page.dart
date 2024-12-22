import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskly/models/task.dart';
class HomePage extends StatefulWidget{
  HomePage();
  @override
  State<StatefulWidget> createState() {
   return _HomePageState();
  }
}


class _HomePageState extends State<HomePage> {
  late double _deviceHeight,_devicewidth;
  
  String? _newTaskContent;
  Box? _box;
  _HomePageState();
  @override
  Widget build(BuildContext context) {
    _deviceHeight =  MediaQuery.of(context).size.height;
    _devicewidth  =  MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight * 0.15 ,
        title: const Text('Task Master',style: TextStyle(fontSize: 25), ),
        backgroundColor: Colors.green,

        shadowColor: Colors.grey,
        elevation: 10.0,
      
      ),
      body: _tasksview(),
      floatingActionButton: _addTaskButton() ,
    );
 
  }


  Widget _tasksview() {
    return FutureBuilder(future: Hive.openBox('tasks'), builder: (BuildContext _context, AsyncSnapshot _snapshot) {
      if (_snapshot.hasData ){
        _box = _snapshot.data;
        return _Tasklist();
      }
      else{
        return const Center(child: CircularProgressIndicator());
      }
    });
  }

  Widget _Tasklist(){
    //Task _newTask = Task(content: "eat", timestamp: DateTime.now(), status: true);
   // _box?.add(_newTask.toMap());
    List tasks = _box!.values.toList();
    print("tasks: $tasks");
    return ListView.builder(itemCount: tasks.length ,
    itemBuilder: (BuildContext _context ,int _index) {
      var task = Task.fromMap(tasks[_index]);
      return  ListTile(
          title:  Text(
            task.content,
          style:  TextStyle(decoration: task.status? TextDecoration.lineThrough: null ,
          )
          ),
          subtitle: Text(task.timestamp.toString()
          ),
          trailing:  Icon(
            task.status? Icons.check_box_outlined : Icons.check_box_outline_blank_outlined,
          color: Colors.green,
          ),
          onTap: (){
            setState(() {
              task.status = !task.status;
            _box!.putAt(_index, task.toMap());
            });
          },

          onLongPress: () {
              _box!.deleteAt(_index);
              setState(() {
                
              });
          },
        );
    });
  }



  Widget _addTaskButton(){
    return FloatingActionButton(onPressed: _displayTaskPopup, 

    
    backgroundColor: Colors.green,
     child: const  Icon(
      Icons.add,
    ),
    );
  }
  void _displayTaskPopup() {
    showDialog(context: context, builder: (BuildContext _context){
      return AlertDialog(
        title: Text("Add Task"),
        content: TextField(
          onSubmitted: (_value) {
            if (_newTaskContent != null){
              var _task = Task(content: _newTaskContent!, timestamp: DateTime.now(), status: false);
              _box!.add(_task.toMap());
            setState(() {
              _newTaskContent=null;
              
            });
            Navigator.pop(_context);
            }
            
          },
          onChanged: (_value) {
           setState(() {
             _newTaskContent= _value; 
             
            });  
          }, 
        ),
      );
    },
    );
  }
}