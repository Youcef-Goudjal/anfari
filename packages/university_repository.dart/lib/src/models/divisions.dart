import 'package:equatable/equatable.dart';
import 'package:university_repository/src/models/models.dart';

class Division extends Equatable {
  final String uid;
  final String universityUid;
  final String name;
  final List<Level> levels;

  Division({
    required this.uid,
    required this.universityUid,
    required this.name,
    List<Level>? levels,
  }) : this.levels = levels ?? [];
  @override
  List<Object?> get props => [uid, universityUid, name, levels];

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "universityUid": universityUid,
    };
  }

  static Division empty = Division(
    uid: "",
    name: "",
    universityUid: "",
  );

  bool get isEmpty => this == empty;
  bool get isNotEmpty => this != empty;

  static Division fromMap(Map<String, dynamic>? data) {
    if (data != null) {
      return Division(
        uid: data["uid"],
        name: data["name"],
        universityUid: data["universityUid"],
      );
    } else {
      return empty;
    }
  }
}
