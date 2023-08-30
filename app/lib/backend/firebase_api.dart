import 'dart:io';

import 'package:app/constant/utils.dart';
import 'package:app/model/Exercise.dart';
import 'package:app/model/gymModel.dart';
import 'package:app/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class FirebaseApi {
  static FirebaseApi instance = FirebaseApi();

  Future<List<GymModel>> gymCategory() async {
    try {
      final data =
          await FirebaseFirestore.instance.collection('gymcategory').get();
      final datalist =
          data.docs.map((e) => (GymModel.fromMap(e.data()))).toList();
      return datalist;
    } catch (e) {
      print('Error: ${e.toString()}');
      throw Exception(e.toString());
    }
  }

  Future<List<Exercise>> trainingApi(String id) async {
    try {
      final data = await FirebaseFirestore.instance
          .collection('gymcategory')
          .doc(id)
          .collection('train')
          .get();
      final datalist =
          data.docs.map((e) => (Exercise.fromMap(e.data()))).toList();

      return datalist;
    } catch (e) {
      print('Error: ${e.toString()}');
      throw Exception(e.toString());
    }
  }

  Future<String> deleteExercise(String id, String categoryId) async {
    try {
      await FirebaseFirestore.instance
          .collection('gymcategory')
          .doc(categoryId)
          .collection('train')
          .doc(id)
          .delete();

      return "Delete Successfully";
    } catch (e) {
      return 'Error';
    }
  }

  Future<String> updateExercise(Exercise exercise, String categoryId) async {
    try {
      await FirebaseFirestore.instance
          .collection('gymcategory')
          .doc(categoryId)
          .collection('train')
          .doc(exercise.id)
          .update(exercise.toMap());

      return "Update Successfully";
    } catch (e) {
      return 'Error';
    }
  }

  Future<Exercise> addExercise(
      File image, String name, String sets, String categoryId) async {
    try {
      DocumentReference reference = FirebaseFirestore.instance
          .collection('gymcategory')
          .doc(categoryId)
          .collection('train')
          .doc();
      String imageurl = await uploadUserImage(reference.id, image);
      Exercise exercisedata =
          Exercise(id: reference.id, image: imageurl, name: name, sets: sets);
      reference.set(exercisedata.toMap());
      return exercisedata;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> uploadUserImage(String id, File image) async {
    final taskSnapshot = await FirebaseStorage.instance.ref(id).putFile(image);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }

  //For authentication:
  Future<bool> registerApi(BuildContext context, String email, String name,
      String phone, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      userModel userdata = userModel(
          id: userCredential.user!.uid,
          roll: 'user',
          name: name,
          phone: phone,
          email: email);
      FirebaseFirestore.instance
          .collection('user')
          .doc(userdata.id)
          .set(userdata.toMap());
      ShowCustomDialog(context, 'Registration Successfully!');

      return true;
    } on FirebaseAuthException catch (e) {
      ShowCustomDialog(context, e.code.toString());
      return false;
    }
  }

  Future<bool> loginApi(BuildContext context, email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      ShowCustomDialog(context, e.code.toString());
      return false;
    }
  }

  Future<userModel> userInfo() async {
    try {
      final data = await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      return userModel.fromMap(data.data()!);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
