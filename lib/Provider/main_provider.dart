import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:new_machine_test/Constants/functions.dart';
import 'package:new_machine_test/Screens/Task/task_list_screen.dart';

import '../Constants/url.dart';
import '../Model/task_model.dart';
import 'api_service.dart';

class MainProvider extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? name;
  String? position;
  String? profileImage;
  String usernameError = '';
  String passwordError = '';

  bool password = false;

  Future<void> login(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse("${apiUrl}/auth/login"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': userNameController.text,
          'password': passwordController.text,
        }),
      );

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          authToken = jsonResponse['token'];
          name = jsonResponse['name'];
          position = jsonResponse['position'];
          profileImage = jsonResponse['image'];
          fetchTasks();
          callNext(TaskListPage(), context);
        } else if (response.statusCode == 401) {
          final jsonResponse = json.decode(response.body);
          String error = jsonResponse['error'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error)),
          );
        } else {
          throw Exception('Failed to login');
        }

    } catch (e) {
      print("exception  $e ");
    }
    notifyListeners();
  }

  final TaskService _taskService = TaskService();
  List<Task> _tasks = [];
  bool _isLoading = false;

  List<Task> get tasks => _tasks;

  bool get isLoading => _isLoading;

  Future<void> fetchTasks() async {
EasyLoading.show(status: 'Loading...');
    notifyListeners();

    try {
      final response = await _taskService.getTasks();

      if (response.containsKey('data')) {
        final List<dynamic> taskData = response['data'];
        _tasks = taskData.map((task) => Task.fromJson(task)).toList();
        notifyListeners();

      } else {

        print('No tasks found in response');
        _tasks = [];
      }
    } catch (e) {

      print('Error fetching tasks: $e');
      _tasks = [];
    }

    EasyLoading.dismiss();
    notifyListeners();
  }

  Future<void> addTask(
      BuildContext context, String title, String description) async {
    await _taskService.createTask(context, title, description);
    await fetchTasks();
    notifyListeners();

  }

  Future<void> updateTask(
      BuildContext context, int id, String title, String description) async {
    await _taskService.updateTask(context, id, title, description);
    await fetchTasks();
    notifyListeners();

  }





  Future<void> deleteTask(BuildContext context, int id) async {
    await _taskService.deleteTask(id);
    await fetchTasks();

    finish(context);
    notifyListeners();
  }

  toggleVisibility() {
    if (password == true) {
      password = false;
    } else {
      password = true;
    }
    notifyListeners();
  }

  clearController() {
    userNameController.clear();
    passwordController.clear();

    notifyListeners();
  }
}
