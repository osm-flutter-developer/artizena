
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glassify/database/models/abstractions/model.dart';



class DesignComment extends ModelAbstraction<DocumentReference> {
  final String comment;
  final DateTime date;
  final DocumentReference customerId;

  DesignComment({required DocumentReference documentRef,
    required this.comment,
    required this.date,
    required this.customerId,
  }) : super(documentRef);

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }

}