
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task{
@HiveField(0)
String content;
@HiveField(1)
DateTime timestamp;
@HiveField(2)
bool status;

Task({
  required this.content,
  required this.timestamp,
  required this.status,
});

factory Task.fromMap(Map task){
  return Task(content: task["content"],
   timestamp:task["timestamp"], 
   status: task["status"],
   );}

Map toMap(){
  return {
    "content":content,
    "timestamp":timestamp,
    "status":status,
  };
}

}