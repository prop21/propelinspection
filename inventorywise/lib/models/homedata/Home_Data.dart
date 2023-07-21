class HomeData {
  int? count;
  List<Rows>? rows;

  HomeData({this.count, this.rows});

  HomeData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(new Rows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rows {
  int? id;
  String? propertyAddress;
  String? tenantName;
  String? inspectorName;
  String? inspectionDate;
  String? ecpExpDate;
  String? ecirExpDate;
  String? gasSafetyCertificateExpDate;
  String? electricityMeter;
  String? gasMeter;
  String? waterMeter;
  String? smokeAlarm;
  String? coAlarm;
  String? heatingSystem;
  SignatureInspector? signatureInspector;
  String? advisedTenantTo;
  String? askedLandlordTo;
  String? contractorInstructed;
  String? gasMeterReading;
  String? electricityMeterReading;
  String? types;
  SignatureInspector? signatureTenant;
  String? finalRemarks;
  String? mainImg;
  String? waterMeterReading;
  String? electricityMeterImg;
  String? gasMeterImg;
  String? waterMeterImg;
  String? smokeAlarmFrontImg;
  String? smokeAlarmBackImg;
  String? coAlarmFrontImg;
  String? coAlarmBackImg;
  String? heatingSystemImg;
  String? created;
  String? updated;
  int? accountId;
  List<PropertyDetails>? propertyDetails;

  Rows(
      {this.id,
      this.propertyAddress,
      this.tenantName,
      this.inspectorName,
      this.inspectionDate,
      this.ecpExpDate,
      this.ecirExpDate,
      this.gasSafetyCertificateExpDate,
      this.electricityMeter,
      this.gasMeter,
      this.waterMeter,
      this.smokeAlarm,
      this.coAlarm,
      this.heatingSystem,
      this.signatureInspector,
      this.advisedTenantTo,
      this.askedLandlordTo,
      this.contractorInstructed,
      this.gasMeterReading,
      this.electricityMeterReading,
      this.types,
      this.signatureTenant,
      this.finalRemarks,
      this.mainImg,
      this.waterMeterReading,
      this.electricityMeterImg,
      this.gasMeterImg,
      this.waterMeterImg,
      this.smokeAlarmFrontImg,
      this.smokeAlarmBackImg,
      this.coAlarmFrontImg,
      this.coAlarmBackImg,
      this.heatingSystemImg,
      this.created,
      this.updated,
      this.accountId,
      this.propertyDetails});

  Rows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyAddress = json['property_address'];
    tenantName = json['tenant_name'];
    inspectorName = json['inspector_name'];
    inspectionDate = json['inspection_date'];
    ecpExpDate = json['ecp_exp_date'];
    ecirExpDate = json['ecir_exp_date'];
    gasSafetyCertificateExpDate = json['gas_safety_certificate_exp_date'];
    electricityMeter = json['electricity_meter'];
    gasMeter = json['gas_meter'];
    waterMeter = json['water_meter'];
    smokeAlarm = json['smoke_alarm'];
    coAlarm = json['co_alarm'];
    heatingSystem = json['heating_system'];
    signatureInspector = json['signature_inspector'] != null
        ? new SignatureInspector.fromJson(json['signature_inspector'])
        : null;
    advisedTenantTo = json['advised_tenant_to'];
    askedLandlordTo = json['asked_landlord_to'];
    contractorInstructed = json['contractor_instructed'];
    gasMeterReading = json['gas_meter_reading'];
    electricityMeterReading = json['electricity_meter_reading'];
    types = json['types'];
    signatureTenant = json['signature_tenant'] != null
        ? new SignatureInspector.fromJson(json['signature_tenant'])
        : null;
    finalRemarks = json['final_remarks'];
    mainImg = json['main_img'];
    waterMeterReading = json['water_meter_reading'];
    electricityMeterImg = json['electricity_meter_img'];
    gasMeterImg = json['gas_meter_img'];
    waterMeterImg = json['water_meter_img'];
    smokeAlarmFrontImg = json['smoke_alarm_front_img'];
    smokeAlarmBackImg = json['smoke_alarm_back_img'];
    coAlarmFrontImg = json['co_alarm_front_img'];
    coAlarmBackImg = json['co_alarm_back_img'];
    heatingSystemImg = json['heating_system_img'];
    created = json['created'];
    updated = json['updated'];
    accountId = json['accountId'];
    if (json['property_details'] != null) {
      propertyDetails = <PropertyDetails>[];
      json['property_details'].forEach((v) {
        propertyDetails!.add(new PropertyDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_address'] = this.propertyAddress;
    data['tenant_name'] = this.tenantName;
    data['inspector_name'] = this.inspectorName;
    data['inspection_date'] = this.inspectionDate;
    data['ecp_exp_date'] = this.ecpExpDate;
    data['ecir_exp_date'] = this.ecirExpDate;
    data['gas_safety_certificate_exp_date'] = this.gasSafetyCertificateExpDate;
    data['electricity_meter'] = this.electricityMeter;
    data['gas_meter'] = this.gasMeter;
    data['water_meter'] = this.waterMeter;
    data['smoke_alarm'] = this.smokeAlarm;
    data['co_alarm'] = this.coAlarm;
    data['heating_system'] = this.heatingSystem;
    if (this.signatureInspector != null) {
      data['signature_inspector'] = this.signatureInspector!.toJson();
    }
    data['advised_tenant_to'] = this.advisedTenantTo;
    data['asked_landlord_to'] = this.askedLandlordTo;
    data['contractor_instructed'] = this.contractorInstructed;
    data['gas_meter_reading'] = this.gasMeterReading;
    data['electricity_meter_reading'] = this.electricityMeterReading;
    data['types'] = this.types;
    if (this.signatureTenant != null) {
      data['signature_tenant'] = this.signatureTenant!.toJson();
    }
    data['final_remarks'] = this.finalRemarks;
    data['main_img'] = this.mainImg;
    data['water_meter_reading'] = this.waterMeterReading;
    data['electricity_meter_img'] = this.electricityMeterImg;
    data['gas_meter_img'] = this.gasMeterImg;
    data['water_meter_img'] = this.waterMeterImg;
    data['smoke_alarm_front_img'] = this.smokeAlarmFrontImg;
    data['smoke_alarm_back_img'] = this.smokeAlarmBackImg;
    data['co_alarm_front_img'] = this.coAlarmFrontImg;
    data['co_alarm_back_img'] = this.coAlarmBackImg;
    data['heating_system_img'] = this.heatingSystemImg;
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['accountId'] = this.accountId;
    if (this.propertyDetails != null) {
      data['property_details'] =
          this.propertyDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SignatureInspector {
  String? type;
  List<int>? data;

  SignatureInspector({this.type, this.data});

  SignatureInspector.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['data'] = this.data;
    return data;
  }
}

class PropertyDetails {
  String? name;
  String? description;
  String? floor;
  String? walls;
  String? ceiling;
  String? windows;
  String? doors;
  String? units;
  String? appliances;
  List<PropertyImages>? propertyImages;

  PropertyDetails(
      {this.name,
      this.description,
      this.floor,
      this.walls,
      this.ceiling,
      this.windows,
      this.doors,
      this.units,
      this.appliances,
      this.propertyImages});

  PropertyDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    floor = json['floor'];
    walls = json['walls'];
    appliances = json["appliances"];
    units = json["units"];
    doors = json["doors"];
    ceiling = json['ceiling'];
    windows = json['windows'];
    if (json['property_images'] != null) {
      propertyImages = <PropertyImages>[];
      json['property_images'].forEach((v) {
        propertyImages!.add(new PropertyImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['floor'] = this.floor;
    data['walls'] = this.walls;
    data["units"] = this.units;
    data["appliances"] = this.units;
    data["doors"] = this.doors;
    data['ceiling'] = this.ceiling;
    data['windows'] = this.windows;
    if (this.propertyImages != null) {
      data['property_images'] =
          this.propertyImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PropertyImages {
  int? id;
  String? url;
  String? created;
  Null updated;
  int? propertyDetailId;

  PropertyImages(
      {this.id, this.url, this.created, this.updated, this.propertyDetailId});

  PropertyImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    created = json['created'];
    updated = json['updated'];
    propertyDetailId = json['propertyDetailId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['propertyDetailId'] = this.propertyDetailId;
    return data;
  }
}
