

import 'package:casual_app/constants/global_variables.dart';
import 'package:casual_app/services/base_client.dart';

class JobsRepo{
  Future<dynamic> getAllJobs() async {
    var result = await BaseClient().get(baseUrl, "casual-job/all").catchError((error){
      print(error);
      print("error");
    });
    // print(result);
    return result;
  }

  Future<dynamic> applyJob(int jobId) async {
    var result = await BaseClient().postQueryId(baseUrl, "casual/job/apply?job_id=$jobId").catchError((error){
      print(error);
      print("error");
    });
    print(result);
    return result;
  }

  Future<dynamic> getAllAppliedJobs() async {
    var result = await BaseClient().get(baseUrl, "casual/job/get-applied-jobs").catchError((error){
      print(error);
      print("error");
    });
    // print(result);
    return result;
  }

  Future<dynamic> checkJobIsAppliedOrNot(int jobId) async {
    var result = await BaseClient().get(baseUrl, "casual/job/check-job-is-applied-or-not/$jobId").catchError((error){
      print(error);
      print("error");
    });
    // print(result);
    return result;
  }
  
}