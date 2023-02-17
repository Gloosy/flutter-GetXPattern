class AddressModel {
  late int? _id;
  late String _addressType;
  late String? _contactPersonName;
  late String? _contactPeronNumber;
  late String _address;
  late String _latitude;
  late String _longitude;

  AddressModel(
      {id,
      required addressType,
      contactPersonName,
      contactPeronNumber,
      address,
      latitude,
      longitude}) {
    _id = id;
    _addressType = addressType;
    _contactPersonName = contactPersonName;
    _contactPeronNumber = contactPeronNumber;
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
  }
  String get address => _address;
  String get addressType => _addressType;
  String? get contactPersonName => _contactPersonName;
  String? get contactPersonNumber => _contactPeronNumber;
  String  get latitude => _latitude;
  String get longitude => _longitude;

  AddressModel.fromJson(Map<String,dynamic> json){
    _id = json['id'];
    _addressType = json['address_type']??'';
    _contactPeronNumber = json['contact_person_number']??'';
    _contactPersonName = json['contact_person_name']??'';
    _address = json['address'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }
  Map<String ,dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['address_type'] = _addressType;
    data['contact_person_number'] = _contactPeronNumber;
    data['contact_person_name'] = _contactPersonName;
    data['address'] = _address;
    data['latitude'] = _latitude;
    data['longitude'] = _longitude;
    return data;
  }


}
