import 'package:equatable/equatable.dart';

import '../../university_repository.dart';

class Level extends Equatable {
  final String uid;
  final String divisionUid;
  final String name;
  final List<Class> classes;

  Level({
    required this.uid,
    required this.divisionUid,
    required this.name,
    List<Class>? classes,
  }) : this.classes = classes ?? [];
  @override
  List<Object?> get props => [divisionUid, name, uid];

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "divisionUid": divisionUid,
    };
  }

  static Level empty = Level(
    uid: "",
    name: "",
    divisionUid: "",
  );

  bool get isEmpty => this == empty;
  bool get isNotEmpty => this != empty;

  static Level fromMap(Map<String, dynamic>? data) {
    if (data != null) {
      return Level(
        uid: data["uid"],
        name: data["name"],
        divisionUid: data["divisionUid"],
      );
    } else {
      return empty;
    }
  }
}
