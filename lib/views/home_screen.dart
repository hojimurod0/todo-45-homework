import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homework/controllers/todo_controllers.dart';
import 'package:homework/views/drawer.dart';
import 'package:homework/views/widgets/add_todo.dart';
import 'package:homework/views/widgets/edit_todo.dart';
import 'package:homework/views/widgets/todo_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoControllers todoControllers = TodoControllers();
  @override
  Widget build(BuildContext context) {
    Map exercise = todoControllers.todoChecks();
    return Scaffold(
      drawer: Drawers(),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'Todo App',
          style: GoogleFonts.poppins(
              textStyle: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, dynamic>? data = await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (ctx) {
              return AddTodo();
            },
          );

          if (data?['name'] != null) {
            print("birinchi if");
            if (data!['date'] != '') {
              print(data['date']);
              print("ikkinchi if");
              todoControllers.add(data['name'], data['date'], false);
            } else {
              todoControllers.add(
                  data['name'], DateTime.now().toString().split(' ')[0], false);
              print(data['date']);
              print("object");
            }
          }
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(30),
          Center(
            child: Container(
              width: 370,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bajarilgan: ${exercise['bajarilgan']}',
                    style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w700,
                        fontSize: 17),
                  ),
                  Text(
                    'Bajarilmagan: ${exercise['bajarilmagan']}',
                    style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                        fontSize: 17),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 600,
            child: ListView.builder(
                itemCount: todoControllers.list.length,
                itemBuilder: (ctx, index) {
                  return TodoWidget(
                    todoModels: todoControllers.list[index],
                    onDelete: () {
                      todoControllers.delete(index);
                      setState(() {});
                    },
                    onEdit: () async {
                      Map<String, dynamic>? data = await showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (ctx) {
                          return EditTodo(
                            index: index,
                          );
                        },
                      );
                      if (data?['date'].isEmpty) {
                        todoControllers.edit(data!['name'],
                            DateTime.now().toString().split(' ')[0], index);
                      } else {
                        todoControllers.edit(
                            data!['name'], data['date'], index);
                      }
                      setState(() {});
                    },
                    onPress: () {
                      setState(() {});
                    },
                    onTapp: () {
                      todoControllers.list[index].isDone =
                          !todoControllers.list[index].isDone;
                      setState(() {});
                    },
                    id: index,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
