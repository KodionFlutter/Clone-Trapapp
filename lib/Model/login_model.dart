class LoginModel {
  int? clientId;
  String? message;
  String? token;
  String? clientLogo;
  int? superAdmin;
  int? role;
  bool? success;
  bool? resetPassword;
  int? userId;
  String? email;

  LoginModel(
      {this.clientId,
        this.message,
        this.token,
        this.clientLogo,
        this.superAdmin,
        this.role,
        this.success,
        this.resetPassword,
        this.userId,
        this.email});

  LoginModel.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    message = json['message'];
    token = json['token'];
    clientLogo = json['clientLogo'];
    superAdmin = json['super_admin'];
    role = json['role'];
    success = json['success'];
    resetPassword = json['reset_password'];
    userId = json['user_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_id'] = this.clientId;
    data['message'] = this.message;
    data['token'] = this.token;
    data['clientLogo'] = this.clientLogo;
    data['super_admin'] = this.superAdmin;
    data['role'] = this.role;
    data['success'] = this.success;
    data['reset_password'] = this.resetPassword;
    data['user_id'] = this.userId;
    data['email'] = this.email;
    return data;
  }
}
