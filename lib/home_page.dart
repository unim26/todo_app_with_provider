import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/models/todo_model.dart';
import 'package:todo_provider/providers/todo_provider.dart';
import 'package:todo_provider/widgets/show_my_dialog.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final TextEditingController todocontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double sWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            //app name
            Center(
              child: Text(
                "T O D O",
                style: TextStyle(
                  fontSize: sWidth * .1,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //divider
            Divider(
              color: Colors.grey.shade300,
              thickness: 3,
            ),

            //todos
            context.watch<TodoProvider>().todos.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "No task\n available",
                        style: TextStyle(
                          fontSize: sWidth * .06,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: context.watch<TodoProvider>().todos.length,
                      itemBuilder: (context, index) {
                        //todo
                        final TodoModel todo =
                            context.watch<TodoProvider>().todos[index];

                        // todo name
                        final String? todoTitle = todo.task;

                        //is todo comeleted
                        final bool? istodocompleted = todo.iscompleted;

                        return Container(
                          padding: EdgeInsets.all(17),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade600,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: sWidth,
                          child: Row(
                            children: [
                              //check box
                              Checkbox(
                                checkColor: Colors.grey.shade200,
                                activeColor: Colors.grey.shade800,
                                value: istodocompleted,
                                onChanged: (value) {
                                  context
                                      .read<TodoProvider>()
                                      .updatetodostatus(value!, index);
                                },
                              ),

                              SizedBox(
                                width: 10,
                              ),

                              //task name
                              SizedBox(
                                width: sWidth * .55,
                                child: Text(
                                  todoTitle!,
                                  style: TextStyle(
                                    color: Colors.grey.shade300,
                                    fontSize: sWidth * .055,
                                    fontWeight: FontWeight.bold,
                                    decoration: istodocompleted == true
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                              ),

                              //delete button
                              istodocompleted == true
                                  ? Expanded(
                                      child: IconButton(
                                        onPressed: () {
                                          //delete todo
                                          context
                                              .read<TodoProvider>()
                                              .deletetodo(index);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.grey.shade900,
                                        ),
                                      ),
                                    )
                                  :

                                  //update button
                                  IconButton(
                                      onPressed: () {
                                        todocontroller.text = todoTitle;
                                        showMyDialog(
                                          buttonname: "Upadate",
                                          context: context,
                                          controller: todocontroller,
                                          sWidth: sWidth,
                                          onPressed: () {
                                            //update todo
                                            context
                                                .read<TodoProvider>()
                                                .deletetodo(index);

                                            context
                                                .read<TodoProvider>()
                                                .updatetodo(
                                                  index,
                                                  TodoModel(
                                                    task: todocontroller.text,
                                                  ),
                                                );
                                            todocontroller.clear();
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.grey.shade900,
                                      ),
                                    ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),

      //button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade500,
        onPressed: () {
          showMyDialog(
            context: context,
            controller: todocontroller,
            sWidth: sWidth,
            buttonname: "Add",
            onPressed: () {
              //Add todo
              context.read<TodoProvider>().addtodo(
                    TodoModel(
                      task: todocontroller.text,
                    ),
                  );

              todocontroller.clear();

              Navigator.pop(context);
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
