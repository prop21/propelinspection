class AddPropertyModel {
  List<PropertyDetails>? propertyDetails;
  int? userId;
  String? propertyAddress;
  String? tenantName;
  String? inspectorName;
  String? inspectiondate;
  String? epcExpiryDate;
  String? ecirExpirydate;
  String? gasSafetyCertificateExpiryDate;
  String? electricityMeter;
  String? gasMeter;
  String? smokeAlarm;
  String? coAlarm;
  String? heatingSystem;
  String? signatureInspector;
  String? advisedTenantTo;
  String? askedLandlordTo;
  bool? contractorInstructed;
  String? gasMeterReading;
  String? electricityMeterReading;
  List<String>? types;
  String? signatureTenant;
  String? finalRemarks;
  String? waterMeter;
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

  AddPropertyModel(
      {this.propertyDetails,
      this.userId,
      this.propertyAddress,
      this.tenantName,
      this.inspectorName,
      this.inspectiondate,
      this.epcExpiryDate,
      this.ecirExpirydate,
      this.gasSafetyCertificateExpiryDate,
      this.electricityMeter,
      this.gasMeter,
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
      this.waterMeter,
      this.mainImg,
      this.waterMeterReading,
      this.electricityMeterImg,
      this.gasMeterImg,
      this.waterMeterImg,
      this.smokeAlarmFrontImg,
      this.smokeAlarmBackImg,
      this.coAlarmFrontImg,
      this.coAlarmBackImg,
      this.heatingSystemImg});

  AddPropertyModel.fromJson(Map<String, dynamic> json) {
    if (json['property_details'] != null) {
      propertyDetails = <PropertyDetails>[];
      json['property_details'].forEach((v) {
        propertyDetails!.add(new PropertyDetails.fromJson(v));
      });
    }
    userId = json['user_id'];
    propertyAddress = json['property_address'];
    tenantName = json['tenant_name'];
    inspectorName = json['inspector_name'];
    inspectiondate = json['inspectiondate'];
    epcExpiryDate = json['epc_expiry_date'];
    ecirExpirydate = json['ecir_expirydate'];
    gasSafetyCertificateExpiryDate = json['gas_safety_certificate_expiry_date'];
    electricityMeter = json['electricity_meter'];
    gasMeter = json['gas_meter'];
    smokeAlarm = json['smoke_alarm'];
    coAlarm = json['co_alarm'];
    heatingSystem = json['heating_system'];
    signatureInspector = json['signature_inspector'];
    advisedTenantTo = json['advised_tenant_to'];
    askedLandlordTo = json['asked_landlord_to'];
    contractorInstructed = json['contractor_instructed'];
    gasMeterReading = json['gas_meter_reading'];
    electricityMeterReading = json['electricity_meter_reading'];
    types = json['types'].cast<String>();
    signatureTenant = json['signature_tenant'];
    finalRemarks = json['final_remarks'];
    waterMeter = json['water_meter'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.propertyDetails != null) {
      data['property_details'] =
          this.propertyDetails!.map((v) => v.toJson()).toList();
    }
    data['user_id'] = this.userId;
    data['property_address'] = this.propertyAddress;
    data['tenant_name'] = this.tenantName;
    data['inspector_name'] = this.inspectorName;
    data['inspectiondate'] = this.inspectiondate;
    data['epc_expiry_date'] = this.epcExpiryDate;
    data['ecir_expirydate'] = this.ecirExpirydate;
    data['gas_safety_certificate_expiry_date'] =
        this.gasSafetyCertificateExpiryDate;
    data['electricity_meter'] = this.electricityMeter;
    data['gas_meter'] = this.gasMeter;
    data['smoke_alarm'] = this.smokeAlarm;
    data['co_alarm'] = this.coAlarm;
    data['heating_system'] = this.heatingSystem;
    data['signature_inspector'] = this.signatureInspector;
    data['advised_tenant_to'] = this.advisedTenantTo;
    data['asked_landlord_to'] = this.askedLandlordTo;
    data['contractor_instructed'] = this.contractorInstructed;
    data['gas_meter_reading'] = this.gasMeterReading;
    data['electricity_meter_reading'] = this.electricityMeterReading;
    data['types'] = this.types;
    data['signature_tenant'] = this.signatureTenant;
    data['final_remarks'] = this.finalRemarks;
    data['water_meter'] = this.waterMeter;
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
  List<String>? images;

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
      this.images});

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
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['floor'] = this.floor;
    data['walls'] = this.walls;
    data["units"] = this.units;
    data["appliances"] = this.appliances;
    data["doors"] = this.doors;
    data['ceiling'] = this.ceiling;
    data['windows'] = this.windows;
    data['images'] = this.images;
    return data;
  }
}
