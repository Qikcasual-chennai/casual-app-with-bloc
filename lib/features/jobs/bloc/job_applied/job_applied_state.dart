
part of 'job_applied_cubit.dart';

@immutable
abstract class JobAppliedState{}

abstract class JobAppliedActionState extends JobAppliedState{}

class JobAppliedInitials extends JobAppliedState{}

class JobAppliedLoading extends JobAppliedState{}

class GetAllAppliedJobsState extends JobAppliedState{
  final List<ApplicantJobModel> appliedJobs;

  GetAllAppliedJobsState({required this.appliedJobs});
}

class AppliedJobsIsEmpty extends JobAppliedState{
  final String msg;

  AppliedJobsIsEmpty({required this.msg});
}