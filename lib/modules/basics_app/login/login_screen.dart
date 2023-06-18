import 'package:afandina/modules/bmi_app/bmi/bmi_screen.dart';
import 'package:flutter/material.dart';
import 'package:afandina/layout/todo_app/todo_layout.dart';
import '../../../shared/components/componentes.dart';
import '../messenger/MessengerScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailcontroller = TextEditingController();

  var passwordcontroller = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cafe Afandina',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  defaultFormField(
                    controller: emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'Email Address',
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'email address must not be empty';
                      }
                      return null;
                    },
                    prefixIcon: Icons.email,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                    
                    controller: passwordcontroller,
                    keyboardType: TextInputType.visiblePassword,
                    labelText: 'Password',
                    prefixIcon: Icons.lock,
                    suffixIcon:
                        isPassword ? Icons.visibility : Icons.visibility_off,
                    onPressedSuffix: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                    isPassword: isPassword,
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'password must not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    width: double.infinity,
                    background: Colors.red,
                    text: 'login',
                    function: () {
                      if (formKey.currentState!.validate()) {
                        print(emailcontroller.text);
                        print(passwordcontroller.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MessengerScreen()),
                        );
                      }
                    },
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
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeLayout(),
                              ));
                        },
                        child: Text('Register Now'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
