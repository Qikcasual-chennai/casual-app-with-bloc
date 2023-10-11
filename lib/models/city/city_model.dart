class CityModel{

  int? id;
  String? city_name;
  bool? status;
  String? createAt;
  String? updatedAt;

  CityModel({ this.id, this.city_name, this.status, this.createAt, this.updatedAt});

  CityModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    city_name = json['city_name'];
    status = json['status'];
    createAt = json['createAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city_name'] = this.city_name;
    data['status'] = this.status;
    data['createAt'] = this.createAt;
    data['updatedAt'] = this.updatedAt;

    return data;
  }

}