part of 'jobs_bloc.dart';

abstract class JobsEvent{}

class GetAllJobsEvent extends JobsEvent{}

class ApplyJobEvent extends JobsEvent{
  final int JobId;

  ApplyJobEvent({required this.JobId});
}

