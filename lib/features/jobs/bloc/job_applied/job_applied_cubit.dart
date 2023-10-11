
import 'package:bloc/bloc.dart';
import 'package:casual_app/features/jobs/repos/jobs_repo.dart';
import 'package:casual_app/models/casualJob/applicant_job_model.dart';
import 'package:flutter/material.dart';

part 'job_applied_state.dart';

class JobAppliedCubit extends Cubit<JobAppliedState>{

  JobsRepo jobsRepo = JobsRepo();
  List<ApplicantJobModel> appliedJobs = <ApplicantJobModel>[];

  JobAppliedCubit(): super(JobAppliedInitials());

  Future<void> getAllAppliedJobs() async {
    emit(JobAppliedLoading());
    appliedJobs = [];
    var result = await jobsRepo.getAllAppliedJobs();

    if(result['status']){
      result['jobs'].forEach((job){
        appliedJobs.add(ApplicantJobModel.fromJson(job));
      });
      emit(GetAllAppliedJobsState(appliedJobs: appliedJobs));
    }else{
      emit(AppliedJobsIsEmpty(msg: result['message']));
    }
  }

}