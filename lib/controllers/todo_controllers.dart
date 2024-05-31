import 'package:homework/models/todo_models.dart';

class TodoControllers {
  List<TodoModels> list = [
    TodoModels(name: 'maktabga borish', date: '2025-02-12', isDone: false),
    TodoModels(name: 'uxlash', date: '2024-05-06', isDone: false),
  ];

  void add(String name, String date, bool isDone) {
    list.add(TodoModels(name: name, date: date, isDone: isDone));
  }

  void delete(int index) {
    list.removeAt(index);
  }

  void edit(String name, String date, int index) {
    list[index].name = name;
    list[index].date = date;
  }

  Map<String, String> todoChecks() {
    int exerciseTrue = 0;
    int exerciseFalse = 0;
    for (var element in list) {
      if (element.isDone) {
        exerciseTrue++;
      } else {
        exerciseFalse++;
      }
    }
    return {
      'bajarilgan': exerciseTrue.toString(),
      'bajarilmagan': exerciseFalse.toString()
    };
  }
}
