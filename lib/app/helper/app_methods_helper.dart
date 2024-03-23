import 'dart:ui' as ui;
import 'package:predator_pest/app/common_imports/common_imports.dart';

enum PermissionType { location, camera, notification, storage }

Future<bool> getPermissionStatus(BuildContext context, PermissionType permissionType) async {
  try {
    // DeviceInfoPlugin plugin = DeviceInfoPlugin();
    // AndroidDeviceInfo android = await plugin.androidInfo;
    // if (android.version.sdkInt == 33 && permissionType == 'storage') {
    //   if (await Permission.photos.request().isGranted) {
    //     return true;
    //   } else if (await Permission.photos.request().isPermanentlyDenied) {
    //     // ignore: use_build_context_synchronously
    //     appPermissionDialog(context, permissionType);
    //   }
    // }

    PermissionStatus status = permissionType == PermissionType.camera
        ? await Permission.camera.status
        : permissionType == PermissionType.location
            ? await Permission.location.status
            : permissionType == PermissionType.notification
                ? await Permission.notification.status
                : permissionType == PermissionType.storage
                    ? await Permission.storage.status
                    : PermissionStatus.granted;

    logs("setting --> $status");

    if (status == PermissionStatus.granted || status == PermissionStatus.limited) {
      return true;
    } else if (status.isDenied || status.isPermanentlyDenied) {
      permissionType == PermissionType.camera
          ? await Permission.camera.request()
          : permissionType == PermissionType.location
              ? await Permission.location.request()
              : permissionType == PermissionType.notification
                  ? await Permission.notification.status
                  : permissionType == PermissionType.storage
                      ? await Permission.storage.request()
                      : PermissionStatus.granted;
      PermissionStatus permissionStatus = permissionType == PermissionType.camera
          ? await Permission.camera.status
          : permissionType == PermissionType.location
              ? await Permission.location.status
              : permissionType == PermissionType.notification
                  ? await Permission.notification.status
                  : permissionType == PermissionType.storage
                      ? await Permission.storage.status
                      : PermissionStatus.granted;
      if (permissionStatus.isDenied || permissionStatus.isPermanentlyDenied) {
        // ignore: use_build_context_synchronously
        appPermissionDialog(context, permissionType);
      }
      return false;
    } else {
      if (permissionType == PermissionType.camera) {
        await Permission.camera.request();
      } else if (permissionType == PermissionType.location) {
        await Permission.location.request();
      } else if (permissionType == PermissionType.notification) {
        await Permission.notification.request();
      } else if(permissionType == PermissionType.storage){
        await Permission.storage.request();
      }
      PermissionStatus status = permissionType == PermissionType.camera
          ? await Permission.camera.status
          : permissionType == PermissionType.location
              ? await Permission.location.status
              : permissionType == PermissionType.notification
                  ? await Permission.notification.status
                  : permissionType == PermissionType.storage ? await Permission.storage.status : PermissionStatus.granted;
      if (status == PermissionStatus.granted) {
        return true;
      }
      return false;
    }
  } catch (e) {
    logs('getPermissionStatus Error --> $e');
    return false;
  }
}

Future<Uint8List> getBytesFromAssetForMarker(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
}
