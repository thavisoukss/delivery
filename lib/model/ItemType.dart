class ItemType {
  String status;
  String message;
  List<Data> data;

  ItemType({this.status, this.message, this.data});

  ItemType.fromJson(Map<String, dynamic> json) {
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
  String iTEMTYPENAME;
  String iTEMTYPEDESC;
  int cATEGORYID;

  Data({this.iD, this.iTEMTYPENAME, this.iTEMTYPEDESC, this.cATEGORYID});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    iTEMTYPENAME = json['ITEM_TYPE_NAME'];
    iTEMTYPEDESC = json['ITEM_TYPE_DESC'];
    cATEGORYID = json['CATEGORY_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ITEM_TYPE_NAME'] = this.iTEMTYPENAME;
    data['ITEM_TYPE_DESC'] = this.iTEMTYPEDESC;
    data['CATEGORY_ID'] = this.cATEGORYID;
    return data;
  }
}