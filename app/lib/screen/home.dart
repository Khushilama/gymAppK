import 'package:app/Route/Routes.dart';
// import 'package:app/backend/firebase_api.dart';
import 'package:app/model/gymModel.dart';
import 'package:app/provider/appProvider.dart';
import 'package:app/screen/Login.dart';
import 'package:app/screen/achievement.dart';
import 'package:app/screen/subHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  void getData() async {
    setState(() {
      isLoading = true;
    });
    final gymProvider = Provider.of<AppProvider>(context, listen: false);
    gymProvider.getUserData();
    await gymProvider.GymApi();
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
    final gymDataInfo = Provider.of<AppProvider>(context, listen: false);
    final userName = gymDataInfo.singleuser?.name ?? 'No Name';
    final userEmail = gymDataInfo.singleuser?.email ?? 'No email';
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
                radius: 16,
                backgroundColor: Color.fromARGB(255, 234, 9, 9),
                child: ClipOval(
                  child: Image.network(
                    'https://images.pexels.com/photos/1431282/pexels-photo-1431282.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                    width: 30,
                    height: 30,
                    fit: BoxFit.fill,
                  ),
                )),
          )
        ],
      ),
      drawer: Drawer(
        width: 280,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 234, 9, 28)),
                currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Center(
                        child: Icon(Icons.person_add_alt_sharp, size: 30))),
                accountName: Text(
                  userName,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                accountEmail: Text(
                  userEmail,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                )),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Profile'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(thickness: 1),
            ),
            ListTile(
              leading: Icon(Icons.key),
              title: Text('Change Password'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(thickness: 1),
            ),
            ListTile(
              leading: Icon(Icons.calendar_view_day_rounded),
              title: Text('Calendar'),
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Achievements'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AchievementsScreen()),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(thickness: 1),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Setting'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(thickness: 1),
            ),
            ListTile(
              leading: Icon(Icons.help_center),
              title: Text('Help & feedback'),
            ),
            ListTile(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Routes.instance.pushUtilRemove(Login(), context);
              },
              leading: Icon(Icons.logout),
              title: Text('Logout'),
            ),
            SizedBox(height: 20),
            Center(child: Text('Version 1.0'))
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 130,
                  // color: Colors.green,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 80,
                        color: Colors.red,
                      ),
                      Positioned(
                        top: 0,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                'https://cdn-images.cure.fit/www-curefit-com/image/upload/c_fill,w_842,ar_1.2,q_auto:eco,dpr_2,f_auto,fl_progressive/image/test/sku-card-widget/gold2.png',
                                width: 390,
                                height: 130,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: gymDataInfo.gymData.length,
                      itemBuilder: (context, index) {
                        GymModel gymdata = gymDataInfo.gymData[index];
                        return Padding(
                            padding: const EdgeInsets.all(10),
                            child: InkWell(
                              onTap: () {
                                Routes.instance.push(
                                    SecondHomePage(gymModel: gymdata), context);
                              },
                              child: Container(
                                width: double.infinity,
                                height: 120,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        gymdata.image!.toString(),
                                        width: double.infinity,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      left: 10,
                                      child: Text(
                                        gymdata.name!.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 10,
                                        left: 10,
                                        child: Icon(
                                          Icons.star,
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                              ),
                            ));
                      }),
                )
              ],
            ),
    );
  }
}
