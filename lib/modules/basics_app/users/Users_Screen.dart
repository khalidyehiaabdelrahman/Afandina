import 'package:flutter/material.dart';

import '../../../models/user/user_model.dart';

class UsersScreen extends StatelessWidget {
  List<UsersModel> users = [
    UsersModel(
      id: 12,
      name: 'omar yehia',
      phone: '01101011444',
    ),
    UsersModel(
      id: 13,
      name: 'abdelrahman yehia',
      phone: '01101011555',
    ),
    UsersModel(
      id: 14,
      name: 'yehia abdelrahman',
      phone: '01101011666',
    ),
    UsersModel(
      id: 12,
      name: 'omar yehia',
      phone: '01101011444',
    ),
    UsersModel(
      id: 13,
      name: 'abdelrahman yehia',
      phone: '01101011555',
    ),
    UsersModel(
      id: 14,
      name: 'yehia abdelrahman',
      phone: '01101011666',
    ),
    UsersModel(
      id: 12,
      name: 'omar yehia',
      phone: '01101011444',
    ),
    UsersModel(
      id: 13,
      name: 'abdelrahman yehia',
      phone: '01101011555',
    ),
    UsersModel(
      id: 14,
      name: 'yehia abdelrahman',
      phone: '01101011666',
    ),
    UsersModel(
      id: 12,
      name: 'omar yehia',
      phone: '01101011444',
    ),
    UsersModel(
      id: 13,
      name: 'abdelrahman yehia',
      phone: '01101011555',
    ),
    UsersModel(
      id: 14,
      name: 'yehia abdelrahman',
      phone: '01101011666',
    ),
    UsersModel(
      id: 12,
      name: 'omar yehia',
      phone: '01101011444',
    ),
    UsersModel(
      id: 13,
      name: 'abdelrahman yehia',
      phone: '01101011555',
    ),
    UsersModel(
      id: 14,
      name: 'yehia abdelrahman',
      phone: '01101011666',
    ),
    UsersModel(
      id: 12,
      name: 'omar yehia',
      phone: '01101011444',
    ),
    UsersModel(
      id: 13,
      name: 'abdelrahman yehia',
      phone: '01101011555',
    ),
    UsersModel(
      id: 14,
      name: 'yehia abdelrahman',
      phone: '01101011666',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => buildUsersItem(users[index]),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 20.0,
          ),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.deepOrangeAccent[400],
          ),
        ),
        itemCount: users.length,
      ),
    );
  }

  Widget buildUsersItem(UsersModel users) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              child: Text(
                '${users.id}',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${users.name}',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${users.phone}',
                  style: TextStyle(
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
