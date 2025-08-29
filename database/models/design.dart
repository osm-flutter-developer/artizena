
import 'package:glassify/database/models/abstractions/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glassify/database/models/design_report.dart';
import 'package:glassify/database/models/designer.dart';



class Design extends ModelAbstraction<String> {
  final String title;
  final String description;
  final DateTime date;
  final String imagePath;
  final Set<String> otherImagesPaths;
  final String designerId;
  final String currency;

  final Set<DocumentReference> _likers = {};
  Set<DocumentReference> get likers => Set.of(_likers);

  final Set<DocumentReference> _dislikers = {};
  Set<DocumentReference> get dislikers => Set.of(_dislikers);

  late double _price;
  double get price => _price;

  final Set<DocumentReference> _transactions = {};
  Set<DocumentReference> get transactions => _transactions;

  DocumentReference? _lastReportId;
  DocumentReference? get lastReportId => _lastReportId;

  final Set<DocumentReference> _comments = {};
  Set<DocumentReference> get comments => _comments;

  final Set<DocumentReference> _reports = {};
  Set<DocumentReference> get reports => _reports;


  Design({required String rowId,
    required this.title,
    required this.description,
    required this.designerId,
    required this.date,
    required this.imagePath,
    required this.otherImagesPaths,
    required Set<DocumentReference> likers,
    required Set<DocumentReference> dislikers,
    required Set<DocumentReference> transactions,
    required Set<DocumentReference> comments,
    required double price,
    required this.currency,
    DocumentReference? lastReportId
  }) : super(rowId) {
    _likers.addAll(likers);
    _dislikers.addAll(dislikers);
    _transactions.addAll(transactions);
    _comments.addAll(comments);
    _price = price;
    _lastReportId = lastReportId;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'DesignId': rowId,
      'Title': title,
      'Description': description,
      'DesignerId': designerId,
      'DateTime': date,
      'ImagePath': imagePath,
      'OtherPaths': otherImagesPaths,
      'Likers': likers,
      'DisLikers': dislikers,
      'Transactions': transactions,
      'Price': price,
      'Currency': currency,
    };
  }

  Future<void> addLiker(DocumentReference liker) async {
    _likers.add(liker);
    _dislikers.remove(liker);
  }

  Future<void> removeLiker(DocumentReference liker) async {
    _likers.remove(liker);
  }

  Future<void> addDisLiker(DocumentReference disliker) async {
    _dislikers.add(disliker);
    _likers.remove(disliker);
  }

  Future<void> removeDisLiker(DocumentReference disliker) async {
    _dislikers.remove(disliker);
  }

  Designer? _designer;
  Designer? get designer => _designer;

  DesignReport? _lastReport;
  DesignReport? get lastReport => _lastReport;




}