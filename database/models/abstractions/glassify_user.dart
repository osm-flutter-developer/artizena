
import 'package:glassify/database/models/abstractions/model.dart';

abstract class GlassifyUser<T> extends ModelAbstraction<T> {

  final String userId;
  final String? email;
  final String? userName;
  final String? password;
  final DateTime joinedDate;
  final GlassifyUserType userType;
  final GlassifyUserStatus userStatus;

  GlassifyUser({required T rowId,
    required this.userId,
    required this.email,
    required this.userName,
    required this.password,
    required this.userStatus,
    required this.userType,
    required this.joinedDate,
  }) : super(rowId);

}



enum GlassifyUserType {
  client, designer, systemUser;
}


enum GlassifyUserStatus {
  enabled, stopped, blocked;
}