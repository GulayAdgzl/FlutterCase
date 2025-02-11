import 'package:fluttecase/models/user.dart';
import 'package:fluttecase/services/user_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();
  List<UserModel> _users = [];
  List<UserModel> _filteredUsers = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<UserModel> get users => _users;
  List<UserModel> get filteredUsers => _filteredUsers;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _users = await _userService.getUsers();
      _filteredUsers = _users;
    } catch (e) {
      print('Error fetching users: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void searchUsers(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredUsers = _users;
    } else {
      _filteredUsers = _users
          .where((user) =>
              user.username.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _filteredUsers = _users;
    notifyListeners();
  }
}
