class Item {
  String status;
  String message;
  List<Data> data;

  Item({this.status, this.message, this.data});

  Item.fromJson(Map<String, dynamic> json) {
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
  String iTEMCODE;
  String iTEMBARCODE;
  String iTEMNAME;
  String iTEMDESC;
  int iTEMPRICE;
  String iTEMCCY;
  int iTEMTYPEID;
  String iTEMTYPENAME;
  int uNITID;
  String uNITNAME;
  String pICNAME;

  Data(
      {this.iD,
      this.iTEMCODE,
      this.iTEMBARCODE,
      this.iTEMNAME,
      this.iTEMDESC,
      this.iTEMPRICE,
      this.iTEMCCY,
      this.iTEMTYPEID,
      this.iTEMTYPENAME,
      this.uNITID,
      this.uNITNAME,
      this.pICNAME});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    iTEMCODE = json['ITEM_CODE'];
    iTEMBARCODE = json['ITEM_BARCODE'];
    iTEMNAME = json['ITEM_NAME'];
    iTEMDESC = json['ITEM_DESC'];
    iTEMPRICE = json['ITEM_PRICE'];
    iTEMCCY = json['ITEM_CCY'];
    iTEMTYPEID = json['ITEM_TYPE_ID'];
    iTEMTYPENAME = json['ITEM_TYPE_NAME'];
    uNITID = json['UNIT_ID'];
    uNITNAME = json['UNIT_NAME'];
    pICNAME = json['PIC_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ITEM_CODE'] = this.iTEMCODE;
    data['ITEM_BARCODE'] = this.iTEMBARCODE;
    data['ITEM_NAME'] = this.iTEMNAME;
    data['ITEM_DESC'] = this.iTEMDESC;
    data['ITEM_PRICE'] = this.iTEMPRICE;
    data['ITEM_CCY'] = this.iTEMCCY;
    data['ITEM_TYPE_ID'] = this.iTEMTYPEID;
    data['ITEM_TYPE_NAME'] = this.iTEMTYPENAME;
    data['UNIT_ID'] = this.uNITID;
    data['UNIT_NAME'] = this.uNITNAME;
    data['PIC_NAME'] = this.pICNAME;
    return data;
  }
}
