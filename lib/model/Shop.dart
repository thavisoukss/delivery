class Shop {
  String status;
  String message;
  List<Data> data;

  Shop({this.status, this.message, this.data});

  Shop.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int iD;
  String sHOPNAME;
  String sHOPADDRESS;
  String tELNO;
  String sHOPTYPE;
  String rEGISTERDATE;
  String lOCATION;
  String sTATUS;
  String lASTS;
  String lONGS;
  String tOKEN;

  Data(
      {this.iD,
      this.sHOPNAME,
      this.sHOPADDRESS,
      this.tELNO,
      this.sHOPTYPE,
      this.rEGISTERDATE,
      this.lOCATION,
      this.sTATUS,
      this.lASTS,
      this.lONGS,
      this.tOKEN});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    sHOPNAME = json['SHOP_NAME'];
    sHOPADDRESS = json['SHOP_ADDRESS'];
    tELNO = json['TEL_NO'];
    sHOPTYPE = json['SHOP_TYPE'];
    rEGISTERDATE = json['REGISTER_DATE'];
    lOCATION = json['LOCATION'];
    sTATUS = json['STATUS'];
    lASTS = json['LASTS'];
    lONGS = json['LONGS'];
    tOKEN = json['TOKEN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['SHOP_NAME'] = this.sHOPNAME;
    data['SHOP_ADDRESS'] = this.sHOPADDRESS;
    data['TEL_NO'] = this.tELNO;
    data['SHOP_TYPE'] = this.sHOPTYPE;
    data['REGISTER_DATE'] = this.rEGISTERDATE;
    data['LOCATION'] = this.lOCATION;
    data['STATUS'] = this.sTATUS;
    data['LASTS'] = this.lASTS;
    data['LONGS'] = this.lONGS;
    data['TOKEN'] = this.tOKEN;
    return data;
  }
}
