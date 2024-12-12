import 'package:flutter/material.dart';
import 'package:frontend/features/user_auth/presentation/widgets/form_container_widget.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign up"),
        ),
        body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FormContainerWidget(
                    hintText: "Email",
                    isPasswordField: false,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FormContainerWidget(
                    hintText: "Username",
                    isPasswordField: false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormContainerWidget(
                    hintText: "Password",
                    isPasswordField: true,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text("Sign up",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold))),
                  )
                ],
              ),
            )));
  }
}
