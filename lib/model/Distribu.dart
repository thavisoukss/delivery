class ListDistribu {
  String status;
  String message;
  List<Data> data;

  ListDistribu({this.status, this.message, this.data});

  ListDistribu.fromJson(Map<String, dynamic> json) {
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
  String dISTRIBUTORNAME;
  String aDDRESS;
  String tELNO;
  String dISTRIBUTORTYPE;
  String lOCATION;
  String sTATUS;
  String aCCOUNTNUMBER1;
  String aCCOUNTNUMBER2;
  String aCCOUNTNUMBER3;
  String aCCOUNTNAME1;
  String aCCOUNTNAME2;
  String aCCOUNTNAME3;
  String lASTS;
  String lONGS;
  String tOKEN;

  Data(
      {this.iD,
      this.dISTRIBUTORNAME,
      this.aDDRESS,
      this.tELNO,
      this.dISTRIBUTORTYPE,
      this.lOCATION,
      this.sTATUS,
      this.aCCOUNTNUMBER1,
      this.aCCOUNTNUMBER2,
      this.aCCOUNTNUMBER3,
      this.aCCOUNTNAME1,
      this.aCCOUNTNAME2,
      this.aCCOUNTNAME3,
      this.lASTS,
      this.lONGS,
      this.tOKEN});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    dISTRIBUTORNAME = json['DISTRIBUTOR_NAME'];
    aDDRESS = json['ADDRESS'];
    tELNO = json['TEL_NO'];
    dISTRIBUTORTYPE = json['DISTRIBUTOR_TYPE'];
    lOCATION = json['LOCATION'];
    sTATUS = json['STATUS'];
    aCCOUNTNUMBER1 = json['ACCOUNT_NUMBER1'];
    aCCOUNTNUMBER2 = json['ACCOUNT_NUMBER2'];
    aCCOUNTNUMBER3 = json['ACCOUNT_NUMBER3'];
    aCCOUNTNAME1 = json['ACCOUNT_NAME1'];
    aCCOUNTNAME2 = json['ACCOUNT_NAME2'];
    aCCOUNTNAME3 = json['ACCOUNT_NAME3'];
    lASTS = json['LASTS'];
    lONGS = json['LONGS'];
    tOKEN = json['TOKEN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['DISTRIBUTOR_NAME'] = this.dISTRIBUTORNAME;
    data['ADDRESS'] = this.aDDRESS;
    data['TEL_NO'] = this.tELNO;
    data['DISTRIBUTOR_TYPE'] = this.dISTRIBUTORTYPE;
    data['LOCATION'] = this.lOCATION;
    data['STATUS'] = this.sTATUS;
    data['ACCOUNT_NUMBER1'] = this.aCCOUNTNUMBER1;
    data['ACCOUNT_NUMBER2'] = this.aCCOUNTNUMBER2;
    data['ACCOUNT_NUMBER3'] = this.aCCOUNTNUMBER3;
    data['ACCOUNT_NAME1'] = this.aCCOUNTNAME1;
    data['ACCOUNT_NAME2'] = this.aCCOUNTNAME2;
    data['ACCOUNT_NAME3'] = this.aCCOUNTNAME3;
    data['LASTS'] = this.lASTS;
    data['LONGS'] = this.lONGS;
    data['TOKEN'] = this.tOKEN;
    return data;
  }
}
