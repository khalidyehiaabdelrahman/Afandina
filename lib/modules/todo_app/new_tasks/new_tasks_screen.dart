import 'package:afandina/layout/todo_app/cubit/cubit.dart';
import 'package:afandina/layout/todo_app/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/componentes.dart';
import '../../../shared/components/constants.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var newTasks = AppCubit.get(context).newTasks;
        return tasksBuilder(
          tasks: newTasks,
        );
      },
    );
  }
}
