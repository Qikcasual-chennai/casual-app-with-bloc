import 'package:bloc/bloc.dart';
import 'package:casual_app/features/jobs/repos/jobs_repo.dart';

part 'check_job_applied_state.dart';

class CheckJobAppliedCubit extends Cubit<CheckJobAppliedState>{

  JobsRepo jobsRepo = JobsRepo();

  CheckJobAppliedCubit() : super (CheckJobAppliedInitials());

  Future<void> checkJobAppliedOrNotEvent({required int jobId}) async {
    emit(CheckJobAppliedLoading());
    var result = await jobsRepo.checkJobIsAppliedOrNot(jobId);
    if(result['status']){
      emit(CheckJobAppliedOrNotState(isApplied: true));
    }else{
      emit(CheckJobAppliedOrNotState(isApplied: false));
    }
  }

}