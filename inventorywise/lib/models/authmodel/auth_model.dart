class AuthModel {
  int? id;
  String? title;
  String? firstName;
  String? lastName;
  String? email;
  String? role;
  bool? status;
  String? created;
  String? updated;
  bool? isVerified;
  String? companyLogo;
  String? company_name;
  String? mobile_number;
  String? jwtToken;
  String? company_address;
  String? company_email;

  AuthModel(
      {this.id,
      this.title,
      this.firstName,
      this.lastName,
      this.email,
      this.company_address,
      this.role,
      this.status,
      this.created,
      this.updated,
      this.company_name,
      this.isVerified,
      this.companyLogo,
      this.mobile_number,
      this.company_email,
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
    company_name = json['company_name'];
    jwtToken = json['jwtToken'];
    mobile_number = json['mobile_number'];
    company_address = json['company_address'];
    company_email = json['company_email'];
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
    data['company_name'] = this.company_name;
    data['jwtToken'] = this.jwtToken;
    data['mobile_number'] = this.mobile_number;
    data['company_address'] = this.company_address;
    data['company_email'] = this.company_email;

    return data;
  }
}
