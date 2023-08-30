import 'dart:io';

import 'package:app/constant/utils.dart';

import 'package:app/model/gymModel.dart';
import 'package:app/provider/appProvider.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Add extends StatefulWidget {
  final GymModel gymModel;
  const Add({super.key, required this.gymModel});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  File? image;
  void TakeImage() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController sets = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final gymInfo = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 234, 9, 16),
        title: Text('Add Exercise'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              TakeImage();
            },
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 60,
              child: image == null
                  ? ClipOval(
                      child: Icon(
                      Icons.camera_alt,
                      size: 60,
                      color: Colors.white,
                    ))
                  : ClipOval(
                      child: Image.file(
                      image!,
                      width: 117,
                      height: 117,
                      fit: BoxFit.cover,
                    )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: name,
              decoration: InputDecoration(hintText: 'Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              keyboardType: TextInputType.phone,
              controller: sets,
              decoration: InputDecoration(hintText: 'Sets'),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(300, 50),
                  backgroundColor: Color.fromARGB(255, 234, 9, 9)),
              onPressed: () {
                // ignore: unnecessary_null_comparison
                if (image == null || name == null || sets == null) {
                  ShowCustomDialog(context, "All Field is Required!");
                } else {
                  gymInfo.addTraining(context, image!, name.text, sets.text,
                      widget.gymModel.id.toString());
                }
              },
              child: Text(
                'Add',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
