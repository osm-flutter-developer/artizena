



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glassify/database/models/abstractions/glassify_user.dart';
import 'package:glassify/database/models/abstractions/model.dart';

class DesignReport extends ModelAbstraction {
  final String report;
  final DateTime date;
  final DocumentReference userId;

  DesignReport({required DocumentReference reference,
    required this.report,
    required this.date,
    required this.userId,
  }) : super(reference);


  GlassifyUser? _user;
  GlassifyUser? get user => _user;

  @override
  Map<String, dynamic> toMap() {
    return {
      'Report': report,
      'Date': date,
      'UserId': userId,
    };
  }

}