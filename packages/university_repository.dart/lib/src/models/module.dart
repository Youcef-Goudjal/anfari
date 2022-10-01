import 'package:equatable/equatable.dart';

class Module extends Equatable {
  final String uid;
  final String classUid;
  final String name;
  final List exams;
  final List tds;
  final List tps;
  final List tests;

  Module({
    required this.uid,
    required this.classUid,
    required this.name,
    List? exams,
    List? tds,
    List? tps,
    List? tests,
  })  : this.exams = exams ?? [],
        this.tds = tds ?? [],
        this.tps = tps ?? [],
        this.tests = tests ?? [];

  Module copyWith(
    String? uid,
    String? classUid,
    String? name,
    List? exams,
    List? tds,
    List? tps,
    List? tests,
  ) =>
      Module(
        uid: uid ?? this.uid,
        classUid: classUid ?? this.classUid,
        name: name ?? this.name,
        exams: exams ?? this.exams,
        tds: tds ?? this.tds,
        tps: tps ?? this.tps,
        tests: tests ?? this.tests,
      );

  @override
  List<Object?> get props => [uid, classUid, name, exams, tds, tests, tps];
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "classUid": classUid,
    };
  }

  static Module empty = Module(
    uid: "",
    name: "",
    classUid: "",
  );

  bool get isEmpty => this == empty;
  bool get isNotEmpty => this != empty;

  static Module fromMap(Map<String, dynamic>? data) {
    if (data != null) {
      return Module(
        uid: data["uid"],
        name: data["name"],
        classUid: data["classUid"],
      );
    } else {
      return empty;
    }
  }
}
