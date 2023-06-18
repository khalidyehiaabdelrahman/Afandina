import 'package:afandina/layout/news_app/cubit/cubit.dart';
import 'package:afandina/layout/todo_app/cubit/cubit.dart';
import 'package:afandina/modules/shop_app/shop_app/login/shop_login.dart';
import 'package:afandina/shared/bloc_observer.dart';
import 'package:afandina/shared/network/local/cache_helper.dart';
import 'package:afandina/shared/network/remote/dio_helper.dart';
import 'package:afandina/shared/styles/themes.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'layout/news_app/news_layout.dart';
import 'layout/todo_app/cubit/states.dart';
import 'modules/basics_app/home/home_screen.dart';
import 'modules/news_app/web_view/web_view_screen.dart';
import 'modules/shop_app/shop_app/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark ?? false));
}

class MyApp extends StatefulWidget {
  MyApp(this.isDark);

  final bool isDark;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  get isDark => null;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppChangeModeState) {
            setState(() {});
          }
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
            home: Directionality(
              textDirection: TextDirection.ltr,
              child: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
