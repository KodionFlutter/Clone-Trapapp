class NFCValidateModel {
  int? iSSCANCOUNTENABLE;
  int? cLIENTID;
  String? aCTIVITYLOCID;
  String? vIDEOURL;
  String? cLIENT;
  String? cLIENTURL;
  bool? success;
  String? sERIALNUMBER;
  String? lOGOPATH;
  String? aCTIVITYID;
  int? iS360;
  int? sCANCOUNT;
  String? lARGELOGO;

  NFCValidateModel(
      {this.iSSCANCOUNTENABLE,
        this.cLIENTID,
        this.aCTIVITYLOCID,
        this.vIDEOURL,
        this.cLIENT,
        this.cLIENTURL,
        this.success,
        this.sERIALNUMBER,
        this.lOGOPATH,
        this.aCTIVITYID,
        this.iS360,
        this.sCANCOUNT,
        this.lARGELOGO});

  NFCValidateModel.fromJson(Map<String, dynamic> json) {
    iSSCANCOUNTENABLE = json['IS_SCANCOUNT_ENABLE'];
    cLIENTID = json['CLIENT_ID'];
    aCTIVITYLOCID = json['ACTIVITY_LOC_ID'];
    vIDEOURL = json['VIDEO_URL'];
    cLIENT = json['CLIENT'];
    cLIENTURL = json['CLIENTURL'];
    success = json['success'];
    sERIALNUMBER = json['SERIAL_NUMBER'];
    lOGOPATH = json['LOGO_PATH'];
    aCTIVITYID = json['ACTIVITY_ID'];
    iS360 = json['IS_360'];
    sCANCOUNT = json['SCANCOUNT'];
    lARGELOGO = json['LARGE_LOGO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IS_SCANCOUNT_ENABLE'] = this.iSSCANCOUNTENABLE;
    data['CLIENT_ID'] = this.cLIENTID;
    data['ACTIVITY_LOC_ID'] = this.aCTIVITYLOCID;
    data['VIDEO_URL'] = this.vIDEOURL;
    data['CLIENT'] = this.cLIENT;
    data['CLIENTURL'] = this.cLIENTURL;
    data['success'] = this.success;
    data['SERIAL_NUMBER'] = this.sERIALNUMBER;
    data['LOGO_PATH'] = this.lOGOPATH;
    data['ACTIVITY_ID'] = this.aCTIVITYID;
    data['IS_360'] = this.iS360;
    data['SCANCOUNT'] = this.sCANCOUNT;
    data['LARGE_LOGO'] = this.lARGELOGO;
    return data;
  }
}
