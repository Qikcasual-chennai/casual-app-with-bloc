import 'package:casual_app/common/widgets/custom_button.dart';
import 'package:casual_app/common/widgets/headTitle.dart';
import 'package:casual_app/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final GlobalKey _forgotPasswordForm = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: forgotPassForm(),
        ),
      ),
    );
  }

  Widget forgotPassForm(){
    return Form(
      key: _forgotPasswordForm,
      child: Column(
      children: [
        const Gap(14),
        const HeadTitle(),
        const Gap(14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Password Reset", style: Theme.of(context).textTheme.bodyLarge,),
            const Gap(14),
            Text("Enter your email address to send password reset email.", style: Styles.headLineStyle4,),
            const Gap(24),
            emailInput(),
            const Gap(34),
            CustomButton(text: "Send", onTap: () {

            },),
            const Gap(14),
          ],
        )
        
      ],
    ));
  }

  Widget emailInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(10),
              labelText: "Email",
              border: OutlineInputBorder()
          ),
        ),
        const Gap(10),
        // const Text("Email field is required!!", style: TextStyle(color: Colors.red),),

      ],
    );
  }

}
