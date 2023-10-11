import 'package:casual_app/common/themes/casualAppThemeData.dart';
import 'package:casual_app/controller/bloc_providers.dart';
import 'package:casual_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/splash/screens/splash_screen.dart';

void main(){
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBlocProviders.allBlocProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Casual App",
        theme: CasualAppTheme.lightThemeM3,
        home: const SplashScreen(),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
