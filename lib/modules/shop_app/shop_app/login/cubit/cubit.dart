import 'package:afandina/models/shop_app/login_model.dart';
import 'package:afandina/modules/shop_app/shop_app/login/cubit/states.dart';
import 'package:afandina/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/network/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.FromJson(value.data);
      print(loginModel?.status);
      print(loginModel?.message);
      print(loginModel?.data?.token);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      assert(error !=null);
      print(error.toString());

      emit(ShopLoginErrorState('Please Check Your Network'));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePassworVisibilitydState());
  }
}
