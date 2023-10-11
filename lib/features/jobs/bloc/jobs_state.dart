part of 'jobs_bloc.dart';

@immutable
abstract class JobsState{}

abstract class JobsActionState{}

class JobsInitials extends JobsState{}

class JobsLoadingState extends JobsState{}
class ApplyJobLoadingState extends JobsState{}

class GetAllJobsState extends JobsState{
  final List<CasualJobModel> casualJobs;

  GetAllJobsState({required this.casualJobs});
}

