part of 'university_bloc.dart';

class UniversityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UniversityFetched extends UniversityEvent {}

class FetchAllDevisionsOfUniversity extends UniversityEvent {
  final int? index;
  final University university;

  FetchAllDevisionsOfUniversity(this.university, [this.index]);

  @override
  List<Object?> get props => [university];
}
