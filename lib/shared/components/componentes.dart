// ignore_for_file: dead_code

import 'package:afandina/modules/news_app/web_view/web_view_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../layout/todo_app/cubit/cubit.dart';

Widget defaultButton({
  required double width,
  required Color background,
  required String text,
  required void Function()? function,
}) =>
    Container(
      width: width,
      color: background,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {},
      child: Text(text.toUpperCase()),
    );

Widget defaultFormField({
  required TextEditingController? controller,
  required TextInputType? keyboardType,
  void Function(String)? onFieldSubmitted,
  Function(String)? onChanged,
  String? Function(String?)? validator,
  String? labelText,
  IconData? prefixIcon,
  void Function()? onTap,
  IconData? suffixIcon,
  bool isPassword = false,
  void Function()? onPressedSuffix,
  bool isClickable = true,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    onFieldSubmitted: onFieldSubmitted,
    obscureText: isPassword,
    onChanged: onChanged,
    enabled: isClickable,
    validator: validator,
    onTap: onTap,
    decoration: InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(
        prefixIcon,
      ),
      suffixIcon: IconButton(
        icon: Icon(suffixIcon),
        onPressed: onPressedSuffix,
      ),
      border: OutlineInputBorder(),
    ),
  );
}

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40.0,
                child: Text('${model['time']}'),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${model['title']}',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${model['date']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              IconButton(
                icon: Icon(
                  Icons.check_box,
                  color: Colors.tealAccent,
                ),
                onPressed: () {
                  AppCubit.get(context).updateData(
                    status: 'done',
                    id: model['id'],
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.archive,
                  color: Colors.deepPurpleAccent,
                ),
                onPressed: () {
                  AppCubit.get(context).updateData(
                    status: 'archive',
                    id: model['id'],
                  );
                },
              ),
            ],
          )),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(
          id: model['id'],
        );
      },
    );

Widget tasksBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 50,
              color: Colors.pinkAccent,
            ),
            Text(
              'no tasks yet , please add some tasks',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget buildArticleItem(articles, context) => InkWell(
      onTap: () {
        navigateTo(
          context,
          WebViewScreen(articles['url']),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                image: DecorationImage(
                  image: NetworkImage('${articles['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 100.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${articles['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${articles['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10,
      ),
      fallback: (context) =>
          isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateAndFinish(context, widget) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
