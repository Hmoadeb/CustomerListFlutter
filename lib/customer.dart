class Customer {
  Customer(
    this.CURRENCYCODE,
    this.CUSTOMER,
    this.KV_PROPERTY,
    this.LANGUAGECODE,
    this.NAME,
    this.STATUS,
    this.STATUSDATE,
  );

  String CURRENCYCODE;
  String CUSTOMER;
  String KV_PROPERTY;
  String LANGUAGECODE;
  String NAME;
  String STATUS;
  String STATUSDATE;

  Customer.fromJson(Map<String, dynamic> json)
      : CURRENCYCODE = json['CURRENCYCODE'].toString(),
        CUSTOMER = json['CUSTOMER'].toString(),
        KV_PROPERTY = json['KV_PROPERTY'].toString(),
        LANGUAGECODE = json['LANGUAGECODE'].toString(),
        NAME = json['NAME'].toString(),
        STATUS = json['STATUS'].toString(),
        STATUSDATE = json['STATUSDATE'].toString();
}
