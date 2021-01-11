class UserLogin {
  String status;
  UserInfo userInfo;
  String token;

  UserLogin({this.status, this.userInfo, this.token});

  UserLogin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userInfo = json['userInfo'] != null
        ? new UserInfo.fromJson(json['userInfo'])
        : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class UserInfo {
  String username;
  String usertype;
  Null shopname;

  UserInfo({this.username, this.usertype, this.shopname});

  UserInfo.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    usertype = json['usertype'];
    shopname = json['shopname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['usertype'] = this.usertype;
    data['shopname'] = this.shopname;
    return data;
  }
}
