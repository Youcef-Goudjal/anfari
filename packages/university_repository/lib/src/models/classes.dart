import 'package:equatable/equatable.dart';

import '../../university_repository.dart';

class Class extends Equatable {
  final String uid;
  final String levelUid;
  final String name;
  final List<Module> modules;

  Class({
    required this.uid,
    required this.levelUid,
    required this.name,
    List<Module>? modules,
  }) : this.modules = modules ?? [];
  @override
  List<Object?> get props => [levelUid, name, uid];
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "levelUid": levelUid,
    };
  }

  static Class empty = Class(
    uid: "",
    name: "",
    levelUid: "",
  );

  bool get isEmpty => this == empty;
  bool get isNotEmpty => this != empty;

  static Class fromMap(Map<String, dynamic>? data) {
    if (data != null) {
      return Class(
        uid: data["uid"],
        name: data["name"],
        levelUid: data["levelUid"],
      );
    } else {
      return empty;
    }
  }
}
