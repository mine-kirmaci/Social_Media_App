import 'dart:convert';

import 'package:social_media_app/data/model/todo_model/todo_model.dart';

import '../../domain/repository/repository.dart';
import '../datasource/network/ApiClient.dart';
import '../model/comments_model/comments_model.dart';
import '../model/user_model/user_model.dart';

class RepositoryImpl implements Repository {
  final ApiClient _apiClient;

  RepositoryImpl(this._apiClient);

  @override
  Future<List<TodoModel>> getAllTodos() async {
    final response = await _apiClient.get("todos");
    if (response!.statusCode == 200) {
      List jsonData = json.decode(response!.body);
      //Logger().i(jsonData);
      return jsonData.map((todo) => TodoModel.fromJson(todo)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() {
    return _apiClient.getUsersFromApi();
  }

  @override
  Future<List<CommentModel>> getAllComments() {
    return _apiClient.getAllComments();
  }
}
