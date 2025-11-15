import 'package:fire_chat/core/constants/colors.dart';
import 'package:fire_chat/core/constants/strings.dart';
import 'package:fire_chat/core/constants/styles.dart';
import 'package:fire_chat/core/enums/enums.dart';
import 'package:fire_chat/core/extension/widget_extension.dart';
import 'package:fire_chat/core/services/auth_service.dart';
import 'package:fire_chat/ui/screens/auth/login/login_viewmodel.dart';
import 'package:fire_chat/ui/widgets/button_widget.dart';
import 'package:fire_chat/ui/widgets/textfield_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return ChangeNotifierProvider(
      create: (context) => LoginViewmodel(AuthService()),
      child: Consumer<LoginViewmodel>(builder: (context, model, _) {
        return Scaffold(
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 1.sw * 0.05, vertical: 10.h)
                      .copyWith(bottom: keyboardSpace + 20.h),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          40.verticalSpace,
                          Text("Login", style: h),
                          5.verticalSpace,
                          Text(
                            "Please Log In To Your Account!",
                            style: body.copyWith(color: grey),
                          ),
                          30.verticalSpace,
                          SizedBox(
                            height: 200.h,
                            child: Image.asset(
                              'assets/login.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          30.verticalSpace,
                          CustomTextField(
                            hintText: "Enter Email",
                            onChanged: model.setEmail,
                          ),
                          20.verticalSpace,
                          CustomTextField(
                            hintText: "Enter password",
                            onChanged: model.setPassword,
                            isPassword: true,
                          ),
                          30.verticalSpace,
                          CustomButton(
                            loading: model.state == ViewState.loading,
                            onPressed: model.state == ViewState.loading
                                ? null
                                : () async {
                              try {
                                await model.login();
                                context.showSnackbar(
                                    "User logged in successfully!");
                              } on FirebaseAuthException catch (e) {
                                context.showSnackbar(e.toString());
                              } catch (e) {
                                context.showSnackbar(e.toString());
                              }
                            },
                            buttonText: "Login",
                          ),
                          20.verticalSpace,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have account? ",
                                style: body.copyWith(color: grey),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, signup);
                                },
                                child: Text(
                                  "Signup",
                                  style:
                                  body.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          20.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
