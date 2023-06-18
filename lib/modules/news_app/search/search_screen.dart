import 'package:afandina/layout/news_app/cubit/cubit.dart';
import 'package:afandina/layout/news_app/cubit/states.dart';
import 'package:afandina/shared/components/componentes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var searchCountroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchCountroller,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  labelText: 'Search',
                  prefixIcon: Icons.search,
                ),
              ),
              Expanded(
                  child: articleBuilder(
                list,
                context,
                isSearch: true,
              )),
            ],
          ),
        );
      },
    );
  }
}
