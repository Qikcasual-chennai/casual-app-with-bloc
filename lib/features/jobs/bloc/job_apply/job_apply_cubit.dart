import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:casual_app/features/jobs/repos/jobs_repo.dart';
import 'package:flutter/material.dart';

part 'job_apply_state.dart';

class JobApplyCubit extends Cubit<JobApplyState>{
  JobsRepo jobsRepo = JobsRepo();
  JobApplyCubit() : super(JobApplyInitials());

  Future<void> emitApplyJob({required int jobId}) async{
    emit(JobApplyLoading());
    print(jobId);
    var result = await jobsRepo.applyJob(jobId);
    if(result['status']){
      emit(JobAppliedSuccessState(msg: result['message']));
    }else{
      print("Not applied");
      print(result);
    }
  }
}