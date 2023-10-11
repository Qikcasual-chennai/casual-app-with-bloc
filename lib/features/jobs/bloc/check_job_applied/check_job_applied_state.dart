part of 'check_job_applied_cubit.dart';

abstract class CheckJobAppliedState{}

abstract class CheckJobAppliedActionState extends CheckJobAppliedState {}

class CheckJobAppliedInitials extends CheckJobAppliedState{}

class CheckJobAppliedLoading extends CheckJobAppliedState{}

class CheckJobAppliedOrNotState extends CheckJobAppliedState{
  final bool isApplied;

  CheckJobAppliedOrNotState({required this.isApplied});
}