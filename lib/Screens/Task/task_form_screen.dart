import 'package:flutter/material.dart';
import 'package:new_machine_test/Constants/functions.dart';
import 'package:new_machine_test/Provider/main_provider.dart';
import 'package:new_machine_test/Widgets/textformfield_widget.dart';
import 'package:provider/provider.dart';

import '../../Constants/colors.dart';
import '../../Model/task_model.dart';

class TaskFormScreen extends StatefulWidget {
  final Task? task;

  const TaskFormScreen({Key? key, this.task}) : super(key: key);

  @override
  _TaskFormScreenState createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.name;
      _descriptionController.text = widget.task!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double textSize = width > 700 ? 22 : width * 0.04;
    double textWidth = width > 700 ? 12 : width * 0.03;
    final taskProvider = Provider.of<MainProvider>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: newBlue,
        leading: IconButton(onPressed: (){
          finish(context);

        }, icon: Icon(Icons.keyboard_arrow_left_sharp,color: basewhite,size: textWidth*2.5,)),
        title: Text(widget.task == null ? 'Create Task' : 'Edit Task',style: TextStyle(color: basewhite,fontSize: textWidth*1.6),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            textFormFieldWidget(context, _titleController, "Title",),

            textFormFieldWidget(context, _descriptionController, "Description",),

            const SizedBox(height: 24.0),
            ElevatedButton(

              onPressed: () async {
                if(_titleController.text.isNotEmpty &&
                _descriptionController.text.isNotEmpty) {
                  if (widget.task == null) {
                    await taskProvider.addTask(
                      context,
                      _titleController.text,
                      _descriptionController.text,
                    );
                  } else {
                    await taskProvider.updateTask(
                      context,
                      widget.task!.id,
                      _titleController.text,
                      _descriptionController.text,
                    );
                  }
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Add title and description')),
                  );
                }

              },
              child: Text(widget.task == null ? 'Create Task' : 'Update Task'),
            ),
          ],
        ),
      ),
    );
  }
}
