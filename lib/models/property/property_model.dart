
import 'package:casual_app/models/casualJob/casual_job_model.dart';
import 'package:casual_app/models/city/city_model.dart';
import 'package:casual_app/models/client/client_model.dart';
import 'package:casual_app/models/manager/manager_model.dart';
import 'package:casual_app/models/property/property_grade_model.dart';
import 'package:casual_app/models/property/property_type_model.dart';

class PropertyModel{
  int? id;
  String? property_id;
  String? property_name;
  String? property_avatar;
  String? address;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? cityId;
  int? clientId;
  int? propertyTypeId;
  int? propertyGradeId;
  CityModel? city;
  ClientModel? client;
  PropertyTypeModel? propertyType;
  PropertyGradeModel? propertyGrade;
  List<CasualJobModel>? casual_jobs;
  List<ManagerModel>? managers;


  PropertyModel({this.id, this.property_id, this.property_name, this.property_avatar,
  this.address, this.active, this.createdAt, this.updatedAt, this.cityId, this.clientId,
  this.propertyTypeId, this.propertyGradeId, this.city, this.client, this.propertyType,
  this.propertyGrade, this.casual_jobs, this.managers});

  PropertyModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    property_id = json['property_id'];
    property_name = json['property_name'];
    property_avatar = json['property_avatar'];
    address = json['address'];
    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    cityId = json['cityId'];
    clientId = json['clientId'];
    propertyTypeId = json['propertyTypeId'];
    propertyGradeId = json['propertyGradeId'];
    city = json['city'] != null ? new CityModel.fromJson(json['city']) : null;
    client = json['client'] != null ? new ClientModel.fromJson(json['client']) : null;
    propertyType = json['property_type'] != null ? new PropertyTypeModel.fromJson(json['property_type']) : null;
    propertyGrade = json['property_grade'] != null ? new PropertyGradeModel.fromJson(json['property_grade']) : null;
    if(json['casual_jobs'] != null){
      casual_jobs = <CasualJobModel>[];
      json['casual_jobs'].forEach((v){
        casual_jobs!.add(new CasualJobModel.fromJson(v));
      });
    }
    if(json['managers'] != null){
      managers = <ManagerModel>[];
      json['managers'].forEach((v){
        managers!.add(ManagerModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['property_id'] = this.property_id;
    data['property_name'] = this.property_name;
    data['property_avatar'] = this.property_avatar;
    data['address'] = this.address;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['cityId'] = this.cityId;
    data['clientId'] = this.clientId;
    data['propertyTypeId'] = this.propertyTypeId;
    data['propertyGradeId'] = this.propertyGradeId;
    if(this.city != null){
      data['city'] = this.city!.toJson();
    }
    if(this.client != null){
      data['client'] = this.client!.toJson();
    }
    if(this.propertyType != null){
      data['city'] = this.propertyType!.toJson();
    }
    if(this.propertyGrade != null){
      data['client'] = this.propertyGrade!.toJson();
    }

    if(this.casual_jobs != null){
      data['casual_jobs'] = this.casual_jobs!.map((v) => v.toJson()).toList();
    }

    if(this.managers != null){
      data['managers'] = this.managers!.map((v) => v.toJson()).toList();
    }

    return data;
  }

}