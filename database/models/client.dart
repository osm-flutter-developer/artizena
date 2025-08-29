
import 'package:glassify/database/models/abstractions/glassify_user.dart';



class Client extends GlassifyUser<String> {
  final String clientName;

  Client({
    required super.rowId,
    required super.userId,
    required super.joinedDate,
    required super.email,
    required super.userName,
    required super.password,
    super.userStatus = GlassifyUserStatus.enabled,
    required this.clientName,
  }): super(userType: GlassifyUserType.client);

  @override
  Map<String, dynamic> toMap() {
    return {
      'UserId': userId,
      'Name': clientName,
      'Email': email,
      'UserName': userName,
      'Password': password,
      'UserType': userType,
      'UserStatus': userStatus,
    };
  }

}