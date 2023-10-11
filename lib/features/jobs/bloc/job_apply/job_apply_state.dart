part of 'job_apply_cubit.dart';

@immutable
abstract class JobApplyState{}

abstract class JobApplyActionState extends JobApplyState{}

class JobApplyInitials extends JobApplyState{}

class JobApplyLoading extends JobApplyState{}

class JobAppliedState extends JobApplyState{}

class JobAppliedSuccessState extends JobApplyActionState{
  final String msg;

  JobAppliedSuccessState({required this.msg});
}
