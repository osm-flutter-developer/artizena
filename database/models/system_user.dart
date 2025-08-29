
import 'package:glassify/database/models/abstractions/glassify_user.dart';



class SystemUser extends GlassifyUser<String> {
  final String systemUserName;

  SystemUser({
    required super.rowId,
    required super.userId,
    required super.joinedDate,
    required super.email,
    required super.userName,
    required super.password,
    required super.userStatus,
    required this.systemUserName,
  }): super(userType: GlassifyUserType.systemUser);

  @override
  Map<String, dynamic> toMap() {
    return {
      'UserId': userId,
      'Name': systemUserName,
      'Email': email,
      'UserName': userName,
      'Password': password,
      'UserType': userType,
      'UserStatus': userStatus,
    };
  }

}