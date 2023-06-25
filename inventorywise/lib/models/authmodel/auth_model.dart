class AuthModel {
  int? id;
  String? title;
  String? firstName;
  String? lastName;
  String? email;
  String? role;
  bool? status;
  String? created;
  Null? updated;
  bool? isVerified;
  String? companyLogo;
  String? jwtToken;

  AuthModel(
      {this.id,
        this.title,
        this.firstName,
        this.lastName,
        this.email,
        this.role,
        this.status,
        this.created,
        this.updated,
        this.isVerified,
        this.companyLogo,
        this.jwtToken});

  AuthModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    role = json['role'];
    status = json['status'];
    created = json['created'];
    updated = json['updated'];
    isVerified = json['isVerified'];
    companyLogo = json['company_logo'];
    jwtToken = json['jwtToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['role'] = this.role;
    data['status'] = this.status;
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['isVerified'] = this.isVerified;
    data['company_logo'] = this.companyLogo;
    data['jwtToken'] = this.jwtToken;
    return data;
  }
}

