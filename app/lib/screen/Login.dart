import 'package:app/Route/Routes.dart';
import 'package:app/backend/firebase_api.dart';
import 'package:app/constant/utils.dart';
import 'package:app/screen/Register.dart';
import 'package:app/screen/home.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
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
                            BorderSide(color: Color.fromARGB(255, 20, 9, 234))),
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
                  if (_email.text.isEmpty || _password.text.isEmpty) {
                    ShowCustomDialog(context, "All Field is Required");
                  } else {
                    bool isLogged = await FirebaseApi.instance
                        .loginApi(context, _email.text, _password.text);
                    if (isLogged) {
                      Routes.instance.pushUtilRemove(HomeScreen(), context);
                    }
                  }
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",
                    style: TextStyle(fontSize: 16, color: Colors.black)),
                SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    Routes.instance.push(Register(), context);
                  },
                  child: Text(
                    'SignUp',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                )
              ],
            ),
            SizedBox(height: 30),
            Center(
                child: Text(
              'Or',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(300, 50),
                    backgroundColor: Color.fromARGB(255, 234, 9, 9)),
                onPressed: () {},
                child: Row(children: [
                  Icon(Icons.facebook),
                  SizedBox(width: 40),
                  Text('Login with Facebook', style: TextStyle(fontSize: 18))
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(300, 50),
                    side: BorderSide(width: 0.5),
                    backgroundColor: Colors.white),
                onPressed: () {},
                child: Row(children: [
                  Image.network(
                    'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                    width: 30,
                  ),
                  SizedBox(width: 40),
                  Text('Login with Google',
                      style: TextStyle(fontSize: 18, color: Colors.black))
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
