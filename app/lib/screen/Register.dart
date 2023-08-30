import 'package:app/Route/Routes.dart';
import 'package:app/backend/firebase_api.dart';
import 'package:app/constant/utils.dart';
import 'package:app/screen/Login.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Image.network(
              'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs2/121082843/original/75338fb61b8f825e63cca1f0530f631ceeb8c363/do-3d-animated-gym-exercises-and-yoga-poses.png',
              width: double.infinity,
              height: 250,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 234, 9, 9))),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color.fromARGB(255, 234, 9, 9),
                    ),
                    labelText: 'Email',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 234, 9, 9)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 234, 9, 9), width: 2))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _username,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 234, 9, 9))),
                    prefixIcon: Icon(
                      Icons.person_add_alt,
                      color: Color.fromARGB(255, 234, 9, 9),
                    ),
                    labelText: 'Name',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 234, 9, 9)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 234, 9, 9), width: 2))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.phone,
                controller: _phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 234, 9, 9))),
                    prefixIcon: Icon(
                      Icons.call,
                      color: Color.fromARGB(255, 234, 9, 9),
                    ),
                    labelText: 'Phone',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 234, 9, 9)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 234, 9, 9), width: 2))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 234, 9, 9))),
                    prefixIcon: Icon(
                      Icons.key,
                      color: Color.fromARGB(255, 234, 9, 9),
                    ),
                    labelText: 'Password',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 234, 9, 9)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 234, 9, 9), width: 2))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(300, 50),
                    backgroundColor: Color.fromARGB(255, 234, 9, 9)),
                onPressed: () async {
                  if (_email.text.isEmpty ||
                      _password.text.isEmpty ||
                      _username.text.isEmpty ||
                      _phone.text.isEmpty) {
                    ShowCustomDialog(context, "All Field is Required");
                  } else {
                    await FirebaseApi.instance.registerApi(context, _email.text,
                        _username.text, _phone.text, _password.text);
                  }
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                    style: TextStyle(fontSize: 16, color: Colors.black)),
                SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    Routes.instance.push(Login(), context);
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
