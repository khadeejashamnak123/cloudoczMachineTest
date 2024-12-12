import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:new_machine_test/Constants/functions.dart';

import '../Constants/url.dart';

class TaskService {
  Future<void> createTask(
      BuildContext context, String title, String description) async {
    final response = await http.post(
      Uri.parse(
        'https://erpbeta.cloudocz.com/api/app/tasks/store',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: json.encode({
        "name": title,
        "description": description,
        "deadline": "2023-12-21"
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      finish(context);
    } else {
      throw Exception('Failed to create task');
    }
  }

  Future<Map<String, dynamic>> getTasks() async {
    final response = await http
        .get(Uri.parse('https://erpbeta.cloudocz.com/api/app/tasks'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> updateTask(
      BuildContext context, int id, String title, String description) async {
    final response = await http.post(
      Uri.parse('https://erpbeta.cloudocz.com/api/app/tasks/update/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: json.encode({
        'name': title,
        'description': description,
        "deadline": "2023-12-21"
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      finish(context);
    } else {
      throw Exception('Failed to create task');
    }
  }

  Future<void> deleteTask(int id) async {
    final response = await http.post(
      Uri.parse(
        '$apiUrl/app/tasks/destroy/$id',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }
}
