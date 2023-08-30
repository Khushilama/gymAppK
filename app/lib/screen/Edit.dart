import 'dart:io';
import 'package:app/backend/firebase_api.dart';
import 'package:app/model/Exercise.dart';
import 'package:app/model/gymModel.dart';
import 'package:app/provider/appProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Editing extends StatefulWidget {
  final Exercise excerise;
  final GymModel gymModel;
  final int index;
  const Editing(
      {super.key,
      required this.excerise,
      required this.gymModel,
      required this.index});

  @override
  State<Editing> createState() => _EditingState();
}

class _EditingState extends State<Editing> {
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
    final listProduct = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 234, 9, 9),
        title: Text('Editing'),
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
                      child: Image.network(
                      widget.excerise.image.toString(),
                      width: 117,
                      height: 117,
                      fit: BoxFit.cover,
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
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: name,
              decoration: InputDecoration(hintText: widget.excerise.name),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              keyboardType: TextInputType.phone,
              controller: sets,
              decoration: InputDecoration(hintText: widget.excerise.sets),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () async {
                if (image == null && name.text.isEmpty && sets.text.isEmpty) {
                  Navigator.pop(context);
                } else if (image != null) {
                  String imageUrl = await FirebaseApi.instance
                      .uploadUserImage(widget.excerise.id.toString(), image!);
                  Exercise excerise = widget.excerise.copyWith(
                    image: imageUrl,
                    name: name.text.isEmpty
                        ? widget.excerise.name.toString()
                        : name.text,
                    sets: sets.text.isEmpty
                        ? widget.excerise.sets.toString()
                        : sets.text,
                  );
                  listProduct.updateTraining(widget.index, context, excerise,
                      widget.gymModel.id.toString());
                } else {
                  Exercise excerise = widget.excerise.copyWith(
                    name: name.text.isEmpty
                        ? widget.excerise.name.toString()
                        : name.text,
                    sets: sets.text.isEmpty
                        ? widget.excerise.sets.toString()
                        : sets.text,
                  );
                  listProduct.updateTraining(widget.index, context, excerise,
                      widget.gymModel.id.toString());
                }
              },
              child: Text('Update'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 234, 9, 43),
                  fixedSize: Size(350, 50)),
            ),
          )
        ],
      ),
    );
  }
}
