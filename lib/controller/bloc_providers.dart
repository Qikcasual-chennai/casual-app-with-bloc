import 'package:casual_app/features/account/bloc/account_bloc.dart';
import 'package:casual_app/features/auth/bloc/auth_bloc.dart';
import 'package:casual_app/features/city/bloc/city_bloc.dart';
import 'package:casual_app/features/client/bloc/client_bloc.dart';
import 'package:casual_app/features/jobs/bloc/check_job_applied/check_job_applied_cubit.dart';
import 'package:casual_app/features/jobs/bloc/job_applied/job_applied_cubit.dart';
import 'package:casual_app/features/jobs/bloc/job_apply/job_apply_cubit.dart';
import 'package:casual_app/features/jobs/bloc/jobs_bloc.dart';
import 'package:casual_app/features/settings/bloc/settings_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProviders{
  static get allBlocProviders => [
    BlocProvider<AuthBloc>(create: (context) => AuthBloc(),),
    BlocProvider<CityBLoc>(create: (context) => CityBLoc(),),
    BlocProvider<AccountBloc>(create: (context) => AccountBloc(),),
    BlocProvider<SettingsBloc>(create: (context) => SettingsBloc(),),
    BlocProvider<JobsBloc>(create: (context) => JobsBloc(),),
    BlocProvider<JobApplyCubit>(create: (context) => JobApplyCubit(),),
    BlocProvider<JobAppliedCubit>(create: (context) => JobAppliedCubit(),),
    BlocProvider<CheckJobAppliedCubit>(create: (context) => CheckJobAppliedCubit(),),
    BlocProvider<ClientBloc>(create: (context) => ClientBloc(),),
  ];
}