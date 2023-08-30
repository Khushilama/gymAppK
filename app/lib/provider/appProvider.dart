import 'dart:io';

import 'package:app/backend/firebase_api.dart';
import 'package:app/constant/utils.dart';
import 'package:app/model/Exercise.dart';
import 'package:app/model/gymModel.dart';
import 'package:app/model/usermodel.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  userModel? _userData;
  userModel? get singleuser => _userData;

  void getUserData() async {
    _userData = await FirebaseApi.instance.userInfo();
    notifyListeners();
  }

  //for Gym Category:
  List<GymModel> data = [];
  List<GymModel> get gymData => data;
  Future<void> GymApi() async {
    data = await FirebaseApi.instance.gymCategory();
    notifyListeners();
  }

  //For training:
  List<Exercise> exercisedata = [];
  List<Exercise> get trainData => exercisedata;
  Future<void> TrainApi(String id) async {
    exercisedata = await FirebaseApi.instance.trainingApi(id);
    notifyListeners();
  }

  //delete training:
  Future<void> deleteTraining(
      BuildContext context, exercise, String cId) async {
    String value =
        await FirebaseApi.instance.deleteExercise(exercise.id.toString(), cId);
    if (value == 'Delete Successfully') {
      exercisedata.remove(exercise);
      ShowCustomDialog(context, 'Delete Training');
      debugPrint('delete');
    }
    notifyListeners();
  }

  Future<void> updateTraining(
      int index, BuildContext context, exercise, String cId) async {
    // ignore: unused_local_variable
    String value = await FirebaseApi.instance.updateExercise(exercise, cId);
    exercisedata[index] = exercise;
    ShowCustomDialog(context, 'Update Training');
    debugPrint('update');
    notifyListeners();
  }

  Future<void> addTraining(BuildContext context, File image, String name,
      String sets, String categoryId) async {
    Exercise exercised =
        await FirebaseApi.instance.addExercise(image, name, sets, categoryId);
    exercisedata.add(exercised);
    ShowCustomDialog(context, 'Add Training');
    notifyListeners();
  }
}
