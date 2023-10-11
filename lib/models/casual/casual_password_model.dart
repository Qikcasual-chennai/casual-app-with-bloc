class CasualPasswordModel {
  String? passwordCurrent;
  String? password;
  String? passwordConfirmation;

  CasualPasswordModel(
      {this.passwordCurrent, this.password, this.passwordConfirmation});

  getManagerPasswordWithNull(){
    Map<String, dynamic> CasualPasswordWithNull = {
      "passwordCurrent": null,
      "password": null,
      "passwordConfirmation": null
    };

    return CasualPasswordWithNull;
  }

  CasualPasswordModel.fromJson(Map<String, dynamic> json){
    passwordCurrent = json['passwordCurrent'];
    password = json['password'];
    passwordConfirmation = json['passwordConfirmation'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = <String, dynamic>{};

    data['passwordCurrent'] = this.passwordCurrent;
    data['password'] = this.password;
    data['passwordConfirmation'] = this.passwordConfirmation;

    return data;
  }


}
