import 'dart:developer';

import 'package:afandina/layout/news_app/cubit/cubit.dart';
import 'package:afandina/layout/news_app/cubit/states.dart';
import 'package:afandina/shared/components/componentes.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state,){},
      builder:(context,state,){
        var list =NewsCubit.get(context).business ;
        return  articleBuilder (list,context);
      },
    );
  }
}
