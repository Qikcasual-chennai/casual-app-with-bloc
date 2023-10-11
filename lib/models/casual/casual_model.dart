import 'package:casual_app/models/city/city_model.dart';

class CasualModel {
  int? id;
  String? casual_first_name;
  String? casual_last_name;
  String? casual_id;
  String? email;
  String? password;
  String? casual_phone_no;
  String? casual_avatar;
  String? role;
  String? id_proof;
  String? thaiNationalId;
  String? id_card_front_photo;
  String? id_card_back_photo;
  String? date_of_birth;
  String? gender;
  String? remember_token;
  String? password_reset_token;
  String? password_reset_expires;
  String? created_user_id;
  String? modified_user_id;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? cityId;
  CityModel? city;

  CasualModel(
      {this.id,
      this.casual_first_name,
      this.casual_last_name,
      this.casual_id,
      this.email,
      this.password,
      this.casual_phone_no,
      this.casual_avatar,
      this.role,
      this.id_proof,
      this.thaiNationalId,
      this.id_card_front_photo,
      this.id_card_back_photo,
      this.date_of_birth,
      this.gender,
      this.remember_token,
      this.password_reset_token,
      this.password_reset_expires,
      this.created_user_id,
      this.modified_user_id,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.cityId,
      this.city});

  CasualModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    casual_first_name = json['casual_first_name'];
    casual_last_name = json['casual_last_name'];
    casual_id = json['casual_id'];
    email = json['email'];
    password = json['password'];
    casual_phone_no = json['casual_phone_no'];
    casual_avatar = json['casual_avatar'];
    role = json['role'];
    id_proof = json['id_proof'];
    thaiNationalId = json['thaiNationalId'];
    id_card_front_photo = json['id_card_front_photo'];
    id_card_back_photo = json['id_card_back_photo'];
    date_of_birth = json['date_of_birth'];
    gender = json['gender'];
    remember_token = json['remember_token'];
    password_reset_token = json['password_reset_token'];
    password_reset_expires = json['password_reset_expires'];
    created_user_id = json['created_user_id'];
    modified_user_id = json['modified_user_id'];
    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    cityId = json['cityId'];
    city = json['city'] != null ? new CityModel.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['casual_first_name'] = this.casual_first_name;
    data['casual_last_name'] = this.casual_last_name;
    data['casual_id'] = this.casual_id;
    data['email'] = this.email;
    data['password'] = this.password;
    data['casual_phone_no'] = this.casual_phone_no;
    data['casual_avatar'] = this.casual_avatar;
    data['role'] = this.role;
    data['id_proof'] = this.id_proof;
    data['thaiNationalId'] = this.thaiNationalId;
    data['id_card_front_photo'] = this.id_card_front_photo;
    data['id_card_back_photo'] = this.id_card_back_photo;
    data['date_of_birth'] = this.date_of_birth;
    data['gender'] = this.gender;
    data['remember_token'] = this.remember_token;
    data['password_reset_token'] = this.password_reset_token;
    data['password_reset_expires'] = this.password_reset_expires;
    data['created_user_id'] = this.created_user_id;
    data['modified_user_id'] = this.modified_user_id;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['cityId'] = this.cityId;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }

  getCasualDataWithNull(){
    Map<String, dynamic> casualDataWithNull = {
      "id" : null,
      "casual_first_name": null,
      "casual_last_name": null,
      "casual_id": null,
      "email": null,
      "password": null,
      "casual_phone_no": null,
      "casual_avatar": null,
      "role": null,
      "id_proof": null,
      "thaiNationalId": null,
      "id_card_front_photo": null,
      "id_card_back_photo": null,
      "date_of_birth": null,
      "gender": null,
      "active": null,
      "createdAt": null,
      "updatedAt": null,
      "cityId": null,
    };

    return casualDataWithNull;
  }


}
