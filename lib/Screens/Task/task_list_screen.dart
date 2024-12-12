import 'package:flutter/material.dart';
import 'package:new_machine_test/Constants/colors.dart';
import 'package:new_machine_test/Constants/functions.dart';
import 'package:new_machine_test/Provider/main_provider.dart';
import 'package:new_machine_test/Screens/Profile/profile_screen.dart';
import 'package:new_machine_test/Screens/Task/task_form_screen.dart';
import 'package:provider/provider.dart';

import '../../Widgets/deleteAlert.dart';
class TaskListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<MainProvider>(context,listen: false);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double textSize = width > 700 ? 22 : width * 0.04;
    double textWidth = width > 700 ? 12 : width * 0.03;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: newBlue,
        automaticallyImplyLeading: false,
        title:  Text('Task List',style: TextStyle(color: basewhite,fontSize: textWidth*1.6),),
        actions: [
          Consumer<MainProvider>(
            builder: (context,value,child) {
              return InkWell(
                onTap: (){
                  callNext(ProfileScreen(), context);

                },
                child: value.profileImage!=null?CircleAvatar(
                  radius: 20,
                  foregroundImage: NetworkImage(value.profileImage!),
                  backgroundColor: basewhite,
                ):Icon(Icons.perm_identity_outlined),

              );
            }
          ),
          SizedBox(width: width*0.07,)
        ],


      ),
      body:
      Consumer<MainProvider>(
        builder: (context,value,child) {
          return value.tasks.isEmpty?
          Center(
            child: Text("No data found"),
          ):Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                child: ListView.builder(
                        itemCount: taskProvider.tasks.length,
                        itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
                return Card(
                  child: ListTile(
                    title: Text(task.name),
                    subtitle: Text(task.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit,color: Colors.green,),
                          onPressed: () {
                            callNext(TaskFormScreen(task: task), context);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete,color: Colors.red,),
                          onPressed: () async {
                            deleteTask(context,task.id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
                        },
                      ),
              );
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: newBlue,
        onPressed: () {
          callNext(const TaskFormScreen(), context);
        },
        child:  Icon(Icons.add,color: basewhite,),
      ),
    );
  }
}
