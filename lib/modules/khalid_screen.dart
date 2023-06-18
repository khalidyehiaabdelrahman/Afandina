import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class KhalidScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('khalid rousy')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Container(
                child: SpinKitCircle(
                  size: 200,
                  color: Colors.blue,
                ),
              ),
              Container(
                child: SpinKitCircle(
                  size: 200,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
