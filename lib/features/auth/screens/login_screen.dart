import 'dart:async';

import 'package:casual_app/common/widgets/custom_button.dart';
import 'package:casual_app/common/widgets/headTitle.dart';
import 'package:casual_app/common/widgets/loader.dart';
import 'package:casual_app/constants/app_styles.dart';
import 'package:casual_app/constants/utils.dart';
import 'package:casual_app/features/auth/bloc/auth_bloc.dart';
import 'package:casual_app/models/casual/casual_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey _loginForm = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscure = true;

  AuthBloc authBloc = AuthBloc();
  CasualModel casualModel = CasualModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocListener<AuthBloc, AuthState>(
          bloc: authBloc,
          listener: (context, state) {
            if(state is UnAuthorizedState){
              showFlushBar(context, state.msg, Colors.redAccent);
            }
            if(state is HomeNavigateActionState){
              showFlushBar(context, state.msg, Colors.green);
              Timer(const Duration(seconds: 2), () {
                Navigator.pushNamedAndRemoveUntil(context, "/bottom-bar", (route) => false);
              },);
            }
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    // child: Placeholder(),
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  const HeadTitle(),
                  loginForm(),
                  const Divider(
                    height: 16,
                  ),
                  registerWidget(),
                  policyWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginForm() {
    return Form(
      key: _loginForm,
      child: Column(
        children: [
          const Gap(14),
          emailInput(),
          const Gap(14),
          passwordInput(),
          const Gap(24),
          loginButton(),
          const Gap(24),
          forgotPassword(),
          const Gap(24),
        ],
      ),
    );
  }

  Widget emailInput() {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: authBloc,
      builder: (context, state) {
        LoginState? successState;
        if(state is LoginState){
          successState = state;
        }
        // print(successState?.errors['email']);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
                labelText: "Email",
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
            ),
            const Gap(10),
            successState?.errors['email'] != null ?
            Text(successState?.errors['email'], style: const TextStyle(color: Colors.red),) : const Gap(1)
          ],
        );
      },
    );
  }

  Widget passwordInput() {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: authBloc,
      builder: (context, state) {
        LoginState? successState;
        if(state is LoginState){
          successState = state;
        }
        // print(successState?.errors['email']);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: passwordController,
              obscureText: _obscure,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                  labelText: "Password",
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                      icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility))),
            ),
            const Gap(10),
            successState?.errors['password'] != null ?
            Text(successState?.errors['password'], style: const TextStyle(color: Colors.red),) : const Gap(1)
          ],
        );
      },
    );
  }

  Widget loginButton() {
    return BlocBuilder(
      bloc: authBloc,
      builder: (context, state) {
        return state is LoadingState ? const Loader()
            : CustomButton(text: "Login as Casual", onTap: () {
          casualModel.email = emailController.text;
          casualModel.password = passwordController.text;

          authBloc.add(LoginEvent(casualModel: casualModel));
          print("login");

        },);
      },
    );
  }

  Widget forgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/forgot-password");
        },
        child: Text(
          "Forgot Password ?",
          style: Styles.headLineStyle4,
        ),
      ),
    );
  }

  Widget registerWidget(){
    return
      Column(
        children: [
          Text(
            'Find Job and Earn cash'.toUpperCase(),
            style: const TextStyle(
              letterSpacing: 2,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text('Register'),
            onPressed: () {
              Navigator.pushNamed(context, 'casual_register');
            },
          ),
        ],
      );
  }

  Widget policyWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.all(16),
          ),
          child: const Text('Privacy Policy'),
          onPressed: () => {},
        ),
        TextButton(
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.all(16),
          ),
          child: const Text('Terms and condition'),
          onPressed: () => {},
        ),
      ],
    );
  }

}
