import 'package:afandina/layout/news_app/cubit/states.dart';
import 'package:afandina/modules/news_app/business/business_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/settings_screen/settings_screen.dart';
import '../../../modules/news_app/sports/sports_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'settings',
    ),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();
    emit(NewsBottomNavStates());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingStates());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '8621c68939d449f5ba67923e2491a911',
      },
    ).then((value) {
      business = value.data['articles'];
      print(business[10]['title']);
      emit(NewsGetBusinessSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorStates(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingStates());
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '8621c68939d449f5ba67923e2491a911',
        },
      ).then((value) {
        sports = value.data['articles'];
        print(sports[10]['title']);
        emit(NewsGetSportsSuccessStates());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorStates(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessStates());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingStates());
    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '8621c68939d449f5ba67923e2491a911',
        },
      ).then((value) {
        science = value.data['articles'];
        print(science[10]['title']);
        emit(NewsGetScienceSuccessStates());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorStates(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessStates());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingStates());
    search = [];
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '8621c68939d449f5ba67923e2491a911',
      },
    ).then((value) {
      search = value.data['articles'];
      print(search[10]['title']);
      emit(NewsGetSearchSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorStates(error.toString()));
    });
  }
}
