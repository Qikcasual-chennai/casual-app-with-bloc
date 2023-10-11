import 'dart:async';

import 'package:casual_app/common/widgets/custom_appbar.dart';
import 'package:casual_app/common/widgets/custom_button.dart';
import 'package:casual_app/constants/app_styles.dart';
import 'package:casual_app/constants/utils.dart';
import 'package:casual_app/features/account/bloc/account_bloc.dart';
import 'package:casual_app/features/settings/bloc/settings_bloc.dart';
import 'package:casual_app/models/casual/casual_password_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final updatePassword = GlobalKey<FormState>();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _obsecure = true;

  SettingsBloc? settingsBloc;

  @override
  Widget build(BuildContext context) {
    settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return Scaffold(
      appBar: customAppbar(context: context, title: "Change Password", homeVisible: true),
      body: MultiBlocListener(
        listeners: [
          BlocListener(
            bloc: settingsBloc,
            listener: (context, state) {
              if(state is SettingsApiTokenExpired){
                context.read<AccountBloc>().emit(UnAuthorizedState(msg: state.msg));
              }
              if(state is SettingsDataNotifyState){
                showFlushBar(context, state.msg, Styles.warningColor);
              }
              if(state is ChangePasswordSuccessState){
                showFlushBar(context, state.msg, Colors.green);
                Timer(const Duration(seconds: 4), () {
                  Navigator.pop(context);
                });
              }
            },
          )
        ],
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: updatePassword,
              child: Column(
                children: [
                  currentPassword(),
                  const Gap(14),
                  newPassword(),
                  const Gap(14),
                  confirmPassword(),
                  const Gap(24),
                  CustomButton(text: "Update", onTap: updatePass),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  Widget currentPassword(){
    return BlocBuilder(
      bloc: settingsBloc,
      builder: (context, state) {
        ChangePasswordState? successState;
        if(state is ChangePasswordState){
          successState = state;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: currentPasswordController,
              obscureText: _obsecure,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  labelText: "Current Password",
                  suffixIcon: IconButton(
                    icon: Icon(_obsecure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obsecure = !_obsecure;
                      });
                    },
                  ),
                  border: const OutlineInputBorder()
              ),
            ),
            const Gap(10),
            successState?.errors['passwordCurrent'] != null ?
                Text(successState?.errors['passwordCurrent'], style: TextStyle(color: Styles.errorColor),) : const Gap(0.1)
          ],
        );
      },
    );
  }

  Widget newPassword(){
    return BlocBuilder(
      bloc: settingsBloc,
      builder: (context, state) {
        ChangePasswordState? successState;
        if(state is ChangePasswordState){
          successState = state;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: newPasswordController,
              obscureText: _obsecure,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  labelText: "New Password",
                  suffixIcon: IconButton(
                    icon: Icon(_obsecure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obsecure = !_obsecure;
                      });
                    },
                  ),
                  border: const OutlineInputBorder()
              ),
            ),
            const Gap(10),
            successState?.errors['password'] != null ?
            Text(successState?.errors['password'], style: TextStyle(color: Styles.errorColor),) : const Gap(0.1)
          ],
        );
      },
    );
  }

  Widget confirmPassword(){
    return BlocBuilder(
      bloc: settingsBloc,
      builder: (context, state) {
        ChangePasswordState? successState;
        if(state is ChangePasswordState){
          successState = state;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: confirmPasswordController,
              obscureText: _obsecure,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  labelText: "Confirm Password",
                  suffixIcon: IconButton(
                    icon: Icon(_obsecure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obsecure = !_obsecure;
                      });
                    },
                  ),
                  border: const OutlineInputBorder()
              ),
            ),
            const Gap(10),
            successState?.errors['passwordConfirmation'] != null ?
            Text(successState?.errors['passwordConfirmation'], style: TextStyle(color: Styles.errorColor),) : const Gap(0.1)
          ],
        );
      },
    );
  }

  void updatePass(){
      var model = CasualPasswordModel();
      model.passwordCurrent = currentPasswordController.text;
      model.password = newPasswordController.text;
      model.passwordConfirmation = confirmPasswordController.text;

      settingsBloc!.add(UpdatePasswordEvent(casualPasswordModel: model));
  }
  
}
