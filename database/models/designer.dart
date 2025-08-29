
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glassify/database/models/abstractions/glassify_user.dart';



class Designer extends GlassifyUser<String> {
  final String designerName;

  final Set<DocumentReference> posts;

  final Set<DocumentReference> _followers = {};
  Set<DocumentReference> get followers => _followers;

  final Set<DocumentReference> _transactions = {};
  Set<DocumentReference> get transactions => _transactions;

  final Set<DocumentReference> _reviews = {};
  Set<DocumentReference> get reviews => _reviews;

  late int _countRating;
  int get countRating => _countRating;

  Designer({
    required super.rowId,
    required super.userId,
    required super.joinedDate,
    required super.email,
    required super.userName,
    required super.password,
    super.userStatus = GlassifyUserStatus.enabled,
    required this.designerName,
    required this.posts,
    required Set<DocumentReference> followers,
    required Set<DocumentReference> transactions,
    required Set<DocumentReference> reviews,
    required int countRating,
  }): super(userType: GlassifyUserType.designer) {
    _followers.addAll(followers);
    _transactions.addAll(transactions);
    _reviews.addAll(reviews);
    _countRating = countRating;
  }



  @override
  Map<String, dynamic> toMap() {
    return {
      'UserId': userId,
      'Name': designerName,
      'Email': email,
      'UserName': userName,
      'Password': password,
      'UserType': userType,
      'UserStatus': userStatus,
      'Posts': posts,
      'Followers': followers,
      'Transactions': transactions,
      'Reviews': reviews,
      'Rating': countRating,
    };
  }

}