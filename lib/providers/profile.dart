import 'dart:convert';
import 'package:flutter/foundation.dart' show compute, ChangeNotifier;
import 'package:flutter/material.dart';
import 'package:inshape/Backend/ApiData.dart';
import 'package:inshape/data_models/profile.dart';
import 'package:inshape/providers/session.dart';
import 'package:inshape/utils/toast.dart';

class ProfileProvider with ChangeNotifier {
  Profile _profile;

  bool _isQL = true;
  bool _isML = true;
  bool _isWL = true;

  ProfileProvider() {
    //fetchData();
  }

  bool _dataLoaded = false;
  bool _hasError = false;

  pullFromJSON(var response) async {
    _profile = await compute(Profile.getFromJSON, response);
    notifyListeners();
  }

  /// To be called from the HomePage
  fetchData() async {
    if (SessionProvider.jwt.length > 10) {
      if (!_dataLoaded && !_hasError) {
        debugPrint('fetching profile');

        notifyListeners();
        await _fetchProfile22();
      }
    }
  }

  _fetchProfile22() async {
    final response = await ApiData.getDashboard();
    final decoded = json.decode(response);
    if (decoded['error'] == true) {
      _showError('Unable to load dashboard');
      return;
    }

    _profile = decoded['payload']['profile'];
    _isWL = false;
    _isQL = false;
    _isML = false;
    notifyListeners();
    //print(response);
  }

  _showError(String message) {
    AppToast.show(message);
  }

  Profile get profile => _profile;

  set profile(Profile value) {
    _profile = value;
    notifyListeners();
  }

  // getters and setters
  bool get hasError => _hasError;

  set hasError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  bool get dataLoaded => _dataLoaded;

  set dataLoaded(bool value) {
    _dataLoaded = value;
    notifyListeners();
  }

  updateProfileGoal(String goal) {
    profile.goal = goal;
    notifyListeners();
  }

  bool get isWL => _isWL;

  set isWL(bool value) {
    _isWL = value;
    notifyListeners();
  }

  bool get isML => _isML;

  set isML(bool value) {
    _isML = value;
    notifyListeners();
  }

  bool get isQL => _isQL;

  set isQL(bool value) {
    _isQL = value;
    notifyListeners();
  }

  /// data used for creating profile after logging in for the first time
  bool _isLogin = false;
  String _goalId;
  String _gender, _age, _height, _weight;
  int _frequency, _body;
  List _selectedMuscles, _selectedWorkouts;
  var _dietId;
  int _expertise;
  
  int get expertise => _expertise;

  set expertise(int value) {
    _expertise = value;
    notifyListeners();
  }

  get dietId => _dietId;

  set dietId(value) {
    _dietId = value;
    notifyListeners();
  }

  List get selectedMuscles => _selectedMuscles;

  set selectedMuscles(List value) {
    _selectedMuscles = value;
    notifyListeners();
  }

  String get gender => _gender;

  set gender(String value) {
    _gender = value;
    notifyListeners();
  }

  bool get isLogin => _isLogin;

  set isLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }

  String get goalId => _goalId;

  set goalId(String value) {
    _goalId = value;
    notifyListeners();
  }

  get age => _age;

  set age(value) {
    _age = value;
    notifyListeners();
  }

  get height => _height;

  set height(value) {
    _height = value;
    notifyListeners();
  }

  get weight => _weight;

  set weight(value) {
    _weight = value;
    notifyListeners();
  }

  int get frequency => _frequency;

  set frequency(int value) {
    _frequency = value;
    notifyListeners();
  }

  get body => _body;

  set body(value) {
    _body = value;
    notifyListeners();
  }

  get selectedWorkouts => _selectedWorkouts;

  set selectedWorkouts(value) {
    _selectedWorkouts = value;
    notifyListeners();
  }
}
