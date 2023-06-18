import 'package:afandina/shared/components/componentes.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import '../../modules/todo_app/done_tasks/done_tasks_screen.dart';
import '../../modules/todo_app/new_tasks/new_tasks_screen.dart';
import '../../shared/components/constants.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
class HomeLayout extends StatelessWidget {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertToDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.CurrentIndex],
              ),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.CurrentIndex],
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomShown) {
                  if (formkey.currentState!.validate()) {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                  }
                } else {
                  scaffoldkey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                          color: Colors.grey[100],
                          padding: EdgeInsets.all(
                            20.0,
                          ),
                          child: Form(
                            key: formkey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                  controller: titleController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'title must not be empty';
                                    }
                                  },
                                  labelText: 'task title',
                                  prefixIcon: Icons.title,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                defaultFormField(
                                  controller: timeController,
                                  keyboardType: TextInputType.datetime,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'time must not be empty';
                                    }
                                  },
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                      print(value.format(context));
                                    });
                                  },
                                  labelText: 'task time',
                                  prefixIcon: Icons.watch_later_outlined,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                defaultFormField(
                                  controller: dateController,
                                  keyboardType: TextInputType.datetime,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'date must not be empty';
                                    }
                                  },
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2023-02-17'),
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  labelText: 'task date',
                                  prefixIcon: Icons.calendar_today,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(
                cubit.fabIcon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.CurrentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_outline,
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
