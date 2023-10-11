import 'package:casual_app/models/casualJob/casual_job_model.dart';

class ApplicantJobModel {
  int? id;
  String? applicant_job_id;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? casualId;
  int? casualJobId;
  CasualJobModel? casual_job;

  ApplicantJobModel({this.id,
    this.applicant_job_id,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.casualId,
    this.casualJobId,
    this.casual_job
  });

  ApplicantJobModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    applicant_job_id = json['applicant_job_id'];
    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    casualId = json['casualId'];
    casualJobId = json['casualJobId'];
    casual_job = json['casual_job'] != null ? new CasualJobModel.fromJson(json['casual_job']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['applicant_job_id'] = this.applicant_job_id;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['casualId'] = this.casualId;
    data['casualJobId'] = this.casualJobId;
    if(this.casual_job != null){
      data['casual_job'] = this.casual_job!.toJson();
    }
    return data;
  }


}