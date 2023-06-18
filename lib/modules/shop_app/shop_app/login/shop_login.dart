import 'package:afandina/modules/shop_app/shop_app/login/cubit/cubit.dart';
import 'package:afandina/modules/shop_app/shop_app/login/cubit/states.dart';
import 'package:afandina/shared/components/componentes.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../register/shop_register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginScreen extends StatelessWidget{
  @override

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if(state.loginModel != null){
              if (state.loginModel!.status!) {
                print(state.loginModel!.message!);
                print(state.loginModel!.data!.token);
                Fluttertoast.showToast(
                  msg: state.loginModel!.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }else{
                Fluttertoast.showToast(
                  msg: state.loginModel!.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            }

          }
          if(state is ShopLoginErrorState){
          Fluttertoast.showToast(
            msg:state.error ,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('ana rousy'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          labelText: 'Email Address',
                          prefixIcon: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          suffixIcon: ShopLoginCubit.get(context).suffix,
                          onPressedSuffix: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          labelText: 'Password',
                          prefixIcon: Icons.lock,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'login',
                            background: Colors.blue,
                            width: double.infinity,
                          ),
                          fallback: (context) => Center(
                            child: SpinKitSpinningLines(
                              size: 60,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                              ),
                              defaultTextButton(
                                function: () {
                                  navigateTo(
                                    context,
                                    ShopRegisterScreen(),
                                  );
                                },
                                text: 'register',
                              ),
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
