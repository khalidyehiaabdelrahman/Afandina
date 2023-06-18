import 'package:flutter/material.dart';

import '../../../layout/news_app/news_layout.dart';
import '../../shop_app/shop_app/on_boarding/on_boarding_screen.dart';
import '../login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              print('menu');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsLayout(),
                ),
              );
            }),
        title: Text(
          'Cafe Afandina',
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.notification_important),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OnBoardingScreen(),
                  ),
                );
              }),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print('search');
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image(
                  image: AssetImage(
                    'assets/images/rousy.jpg',
                  ),
                  height: 400.0,
                  width: 400.0,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 80.0,
                  color: Colors.black.withOpacity(.1),
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'friends',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: double.infinity,
              color: Colors.cyan,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: Text(
                  'welcom',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
