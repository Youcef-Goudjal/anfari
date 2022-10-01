import 'package:equatable/equatable.dart';
import 'package:university_repository/src/models/models.dart';

class University extends Equatable {
  final String uid;

  /// collage name
  final String name;

  // list of divisions in this university
  final List<Division> divisions;
  University({
    required this.uid,
    required this.name,
    List<Division>? divisions,
  }) : this.divisions = divisions ?? [];

  @override
  List<Object?> get props => [uid, name, divisions];

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
    };
  }

  static University empty = University(uid: "", name: "");

  bool get isEmpty => this == empty;
  bool get isNotEmpty => this != empty;

  static University fromMap(Map<String, dynamic>? data) {
    if (data != null) {
      return University(
        uid: data["uid"],
        name: data["name"],
      );
    } else {
      return empty;
    }
  }
}
