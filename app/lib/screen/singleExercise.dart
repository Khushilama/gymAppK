import 'package:app/Route/Routes.dart';
import 'package:app/constant/utils.dart';
import 'package:app/model/Exercise.dart';
// import 'package:app/provider/appProvider.dart';
import 'package:app/screen/home.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class SingleExercise extends StatefulWidget {
  final List<Exercise> exercise;
  const SingleExercise({super.key, required this.exercise});

  @override
  State<SingleExercise> createState() => _SingleExerciseState();
}

class _SingleExerciseState extends State<SingleExercise> {
  int num = 0;
  @override
  Widget build(BuildContext context) {
    // final gymInfo = Provider.of<AppProvider>(context, listen: true);
    Exercise exercise = widget.exercise[num];
    return Scaffold(
      body: ListView(
        children: [
          Image.network(
            exercise.image!,
            width: double.infinity,
            height: 400,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 30),
          Center(
              child: Text(
            exercise.name!,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          )),
          SizedBox(height: 14),
          Center(
              child: Text(
            'X${exercise.sets}',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          )),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  if (num + 1 > widget.exercise.length - 1) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 5),
                              Text(
                                "Thank You For Finishing This Exercise!",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                              TextButton(
                                onPressed: () {
                                  Routes.instance
                                      .pushUtilRemove(HomeScreen(), context);
                                },
                                child: const Text('Complete'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    num++;
                  }
                });
              },
              child: Text(
                'DONE',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 234, 9, 9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  fixedSize: Size(300, 50)),
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (num <= 0) {
                    ShowCustomDialog(context, 'First Exercise');
                  } else {
                    setState(() {
                      num--;
                    });
                  }
                },
                child: Text(
                  'PREV',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: num <= 0
                        ? Colors.grey
                        : Color.fromARGB(255, 8, 235, 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    fixedSize: Size(130, 40)),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (num + 1 > widget.exercise.length - 1) {
                      Routes.instance.push(HomeScreen(), context);
                    } else {
                      num++;
                    }
                  });
                },
                child: Text(
                  'SKIP',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 8, 235, 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    fixedSize: Size(130, 40)),
              )
            ],
          )
        ],
      ),
    );
  }
}
