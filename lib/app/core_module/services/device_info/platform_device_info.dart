import 'package:platform_device_id/platform_device_id.dart';
import 'package:posto_plus/app/core_module/services/device_info/device_info_interface.dart';

class PlatformDeviceInfo implements IDeviceInfo {
  @override
  Future<DeviceInfo> getDeviceInfo() async {
    final id = await PlatformDeviceId.getDeviceId;

    return DeviceInfo(deviceID: id?.trim() ?? '');
  }
}
