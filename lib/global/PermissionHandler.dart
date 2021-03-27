import 'package:permission_handler/permission_handler.dart';

class PermissionHandler{
  static Permission contacts = Permission.contacts;
  static Permission location = Permission.location;
  static Permission recorder = Permission.microphone;

  static getPermissions(Permission _permissionType) async{
    if (await _permissionType.request().isGranted) {
      return true;
    }else{
      return false;
    }
  }
}