import 'package:app/Route/Routes.dart';

import 'package:app/model/Exercise.dart';
import 'package:app/model/gymModel.dart';
import 'package:app/provider/appProvider.dart';
import 'package:app/screen/Add.dart';
import 'package:app/screen/Edit.dart';
import 'package:app/screen/singleExercise.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SecondHomePage extends StatefulWidget {
  final GymModel gymModel;
  const SecondHomePage({super.key, required this.gymModel});

  @override
  State<SecondHomePage> createState() => _SecondHomePageState();
}

class _SecondHomePageState extends State<SecondHomePage> {
  bool isLoading = false;
  void getData() async {
    setState(() {
      isLoading = true;
    });
    final gymProvider = Provider.of<AppProvider>(context, listen: false);
    await gymProvider.TrainApi(widget.gymModel.id.toString());
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gymInfo = Provider.of<AppProvider>(context, listen: true);
    return Scaffold(
      floatingActionButton: gymInfo.singleuser!.roll == 'admin'
          ? FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 234, 9, 9),
              onPressed: () {
                Routes.instance.push(
                    Add(
                      gymModel: widget.gymModel,
                    ),
                    context);
              },
              child: Icon(Icons.add))
          : null,
      bottomNavigationBar: gymInfo.singleuser!.roll != 'admin'
          ? Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 234, 9, 9)),
                    onPressed: () {
                      Routes.instance.push(
                          SingleExercise(
                            exercise: gymInfo.trainData,
                          ),
                          context);
                    },
                    child: Text(
                      'Start',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
          : null,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  Container(
                    height: 150,
                    child: Stack(
                      children: [
                        Image.network(
                          widget.gymModel.image.toString(),
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: gymInfo.trainData.length,
                        itemBuilder: (context, index) {
                          Exercise exercise = gymInfo.trainData[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: double.infinity,
                                height: 100,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      child: Image.network(
                                        exercise.image.toString(),
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          exercise.name.toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Text('X ${exercise.sets}')
                                      ],
                                    ),
                                    Spacer(),
                                    gymInfo.singleuser!.roll == 'admin'
                                        ? Row(
                                            children: [
                                              InkWell(
                                                  onTap: () async {
                                                    Routes.instance.push(
                                                        Editing(
                                                            excerise: exercise,
                                                            gymModel:
                                                                widget.gymModel,
                                                            index: index),
                                                        context);
                                                  },
                                                  child: Icon(Icons.edit)),
                                              SizedBox(width: 10),
                                              InkWell(
                                                  onTap: () {
                                                    gymInfo.deleteTraining(
                                                        context,
                                                        exercise,
                                                        widget.gymModel.id
                                                            .toString());
                                                  },
                                                  child: Icon(Icons.delete))
                                            ],
                                          )
                                        : Icon(
                                            Icons.check_circle,
                                            size: 28,
                                            color: Colors.grey,
                                          )
                                  ],
                                )),
                          );
                        }),
                  )
                ],
              ),
            ),
    );
  }
}
