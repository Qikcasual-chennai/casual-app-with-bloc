import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:casual_app/features/jobs/repos/jobs_repo.dart';
import 'package:casual_app/models/casualJob/casual_job_model.dart';
import 'package:flutter/material.dart';

part 'jobs_state.dart';
part 'jobs_event.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState>{

  JobsRepo jobsRepo = JobsRepo();
  List<CasualJobModel> casualJobs = <CasualJobModel>[];

  JobsBloc() : super(JobsInitials()){
    on<GetAllJobsEvent>(getAllJobsEvent);
    on<ApplyJobEvent>(applyJobEvent);
  }


  Future<void> getAllJobsEvent(GetAllJobsEvent event, Emitter<JobsState> emit) async {
    emit(JobsLoadingState());
    casualJobs = [];

    var result = await jobsRepo.getAllJobs();

    if(result['status']){
      print("object");
      result['casual_jobs'].forEach((job){
       casualJobs.add(CasualJobModel.fromJson(job));
      });
      emit(GetAllJobsState(casualJobs: casualJobs));

    }else{
      print(result);
    }

  }

  FutureOr<void> applyJobEvent(ApplyJobEvent event, Emitter<JobsState> emit) {
    emit(ApplyJobLoadingState());
    print("Applied" + event.JobId.toString());
    emit(JobsInitials());
  }
}