import 'dart:convert';

abstract class IDeviceInfo {
  Future<DeviceInfo> getDeviceInfo();
}

class DeviceInfo {
  final String deviceID;

  DeviceInfo({
    required this.deviceID,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deviceID': deviceID,
    };
  }

  factory DeviceInfo.fromMap(Map<String, dynamic> map) {
    return DeviceInfo(
      deviceID: map['deviceID'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceInfo.fromJson(String source) =>
      DeviceInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DeviceInfo(deviceID: $deviceID)';

  @override
  bool operator ==(covariant DeviceInfo other) {
    if (identical(this, other)) return true;

    return other.deviceID == deviceID;
  }

  @override
  int get hashCode => deviceID.hashCode;
}
