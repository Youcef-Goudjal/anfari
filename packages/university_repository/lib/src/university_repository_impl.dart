import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:university_repository/university_repository.dart';

class UniversityRepositoryImpl implements UniversityRepository {
  final db = FirebaseFirestore.instance;
  UniversityRepositoryImpl() {
    db.settings = Settings(
      persistenceEnabled: true,
    );
  }

  /// getting ref of [universities],[divisions],[levels],[classes],[modules]
  late final universities = db.collection("universities");
  late final divisions = db.collection("divisions");
  late final levels = db.collection("levels");
  late final classes = db.collection("classes");
  late final modules = db.collection("modules");

  @override
  Future<List<Class>> getAllClassesOfLevel(String levelUid) async {
    return await classes.where("levelUid", isEqualTo: levelUid).get().then(
        (query) => query.docs
            .map((classDoc) => Class.fromMap(classDoc.data()))
            .toList());
  }

  @override
  Future<List<Division>> getAllDivisions(String universityUid) async {
    return await divisions
        .where("universityUid", isEqualTo: universityUid)
        .get()
        .then(
          (query) => query.docs
              .map((universityDoc) => Division.fromMap(universityDoc.data()))
              .toList(),
        );
  }

  @override
  Future<List<Level>> getAllLevelsOfDivision(String divisionUid) async {
    return await levels
        .where("divisionUid", isEqualTo: divisionUid)
        .get()
        .then((query) => query.docs
            .map((divisionDoc) => Level.fromMap(divisionDoc.data()))
            .toList());
  }

  @override
  Future<List<Module>> getAllModulesOfClass(String classeUid) async {
    return await modules.where("classeUid", isEqualTo: classeUid).get().then(
        (query) => query.docs
            .map((moduleDoc) => Module.fromMap(moduleDoc.data()))
            .toList());
  }

  @override
  Future<List<University>> getAllUniversities() async {
    return await universities.get().then((docs) => docs.docs
        .map((universityDoc) => University.fromMap(universityDoc.data()))
        .toList());
  }

  @override
  Future<Class> getClassById(String classUid) async {
    return await classes
        .doc(classUid)
        .get()
        .then((classDoc) => Class.fromMap(classDoc.data()));
  }

  @override
  Future<Division> getDivisionById(String divisionUid) async {
    return await divisions
        .doc(divisionUid)
        .get()
        .then((divisionDoc) => Division.fromMap(divisionDoc.data()));
  }

  @override
  Future<Level> getLevelById(String levelUid) async {
    return await levels
        .doc(levelUid)
        .get()
        .then((levelDoc) => Level.fromMap(levelDoc.data()));
  }

  @override
  Future<University> getUniversityById(String universityUid) async {
    return await universities
        .doc(universityUid)
        .get()
        .then((universityDoc) => University.fromMap(universityDoc.data()));
  }
}
