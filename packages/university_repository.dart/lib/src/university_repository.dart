import 'package:university_repository/university_repository.dart';

abstract class UniversityRepository {
  /// get All universities
  Future<List<University>> getAllUniversities();

  /// get university By Id
  Future<University> getUniversityById(String uid);

  /// get  All divisions of an university
  Future<List<Division>> getAllDivisions(String universityUid);

  /// get devision of specific university by ID
  Future<Division> getDivisionById(String divisionUid);

  /// get All levels of division
  Future<List<Level>> getAllLevelsOfDivision(String divisionUid);

  /// get level By Id
  Future<Level> getLevelById(String LevelUid);

  /// get All classes of specific level
  Future<List<Class>> getAllClassesOfLevel(String LevelUid);

  /// get class By Id
  Future<Class> getClassById(String classUid);

  /// get all modules of spicific class
  Future<List<Module>> getAllModulesOfClass(String moduleUid);
}
