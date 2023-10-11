import 'package:casual_app/features/account/screens/edit_profile_screen.dart';
import 'package:casual_app/features/account/screens/profile_screen.dart';
import 'package:casual_app/features/bottom_bar/screens/bottom_bar.dart';
import 'package:casual_app/features/forgotPassword/screens/forgot_password_screen.dart';
import 'package:casual_app/features/history/screens/history_screen.dart';
import 'package:casual_app/features/home/screens/home_screen.dart';
import 'package:casual_app/features/jobs/screens/job_details_screen.dart';
import 'package:casual_app/features/jobs/screens/jobs_screen.dart';
import 'package:casual_app/features/settings/screens/change_password_screen.dart';
import 'package:casual_app/features/settings/screens/settingsScreen.dart';
import 'package:casual_app/models/casualJob/casual_job_model.dart';
import 'package:flutter/material.dart';
import '../features/auth/screens/login_screen.dart';

class AppRouter{
  MaterialPageRoute? onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case "/login":
        return MaterialPageRoute(builder: (context) => const LoginScreen(),);
      case "/forgot-password":
        return MaterialPageRoute(builder: (context) => const ForgotPasswordScreen(),);
      case "/bottom-bar":
        return MaterialPageRoute(builder: (context) => const BottomBar(),);
      case "/home":
        return MaterialPageRoute(builder: (context) => const HomeScreen(),);
      case "/jobs":
        return MaterialPageRoute(builder: (context) => const JobsScreen(),);
      case "/job-details":
        CasualJobModel jobs = settings.arguments as CasualJobModel;
        return MaterialPageRoute(builder: (context) => JobDetailsScreen(casualJobModel: jobs),);
      case "/history":
        return MaterialPageRoute(builder: (context) => const HistoryScreen(),);
      case "/profile":
        return MaterialPageRoute(builder: (context) => const ProfileScreen(),);
      case "/edit-profile":
        return MaterialPageRoute(builder: (context) => const EditProfileScreen(),);
      case "/settings":
        return MaterialPageRoute(builder: (context) => const SettingsScreen(),);
      case "/change-password":
        return MaterialPageRoute(builder: (context) => const ChangePasswordScreen(),);
      default:
        return MaterialPageRoute(builder: (context) => const Scaffold(
          body: Center(child: Text("No Route Defined!"),),
        ),);
        // return null;
    }
  }
}