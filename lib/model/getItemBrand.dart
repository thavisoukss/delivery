class GetItemBrand {
  String status;
  String message;
  List<Data> data;

  GetItemBrand({this.status, this.message, this.data});

  GetItemBrand.fromJson(Map<String, dynamic> json) {
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
  String bRANDNAME;
  String bRANDDESC;
  int iTEMTYPEID;


  Data({this.iD, this.bRANDNAME, this.bRANDDESC, this.iTEMTYPEID});


  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    bRANDNAME = json['BRAND_NAME'];
    bRANDDESC = json['BRAND_DESC'];
    iTEMTYPEID = json['ITEM_TYPE_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['BRAND_NAME'] = this.bRANDNAME;
    data['BRAND_DESC'] = this.bRANDDESC;
    data['ITEM_TYPE_ID'] = this.iTEMTYPEID;
    return data;
  }
}
