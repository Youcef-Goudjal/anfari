part of 'university_bloc.dart';

enum Status { initial, success, failure }

class UniversityState extends Equatable {
  const UniversityState({
    this.hasReachedMax = false,
    this.universitiesStatus = Status.initial,
    this.devisionsStatus = Status.initial,
    this.universities = const <University>[],
  });

  UniversityState copyWith({
    Status? universitiesStatus,
    Status? devisionsStatus,
    bool? hasReachedMax,
    List<University>? universities,
  }) =>
      UniversityState(
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        universitiesStatus: universitiesStatus ?? this.universitiesStatus,
        devisionsStatus: devisionsStatus ?? this.devisionsStatus,
        universities: universities ?? this.universities,
      );
  @override
  String toString() {
    return "UnversityState { status: $universitiesStatus,hasReachedMax: $hasReachedMax, posts: ${universities.length} }";
  }

  final Status universitiesStatus;
  final Status devisionsStatus;
  final List<University> universities;
  final bool hasReachedMax;

  @override
  List<Object> get props => [universitiesStatus, universities, hasReachedMax];
}
