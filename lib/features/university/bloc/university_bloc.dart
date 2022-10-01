// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:university_repository/university_repository.dart';

part 'university_event.dart';
part 'university_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

const _universitiesLimit = 10;
const throttleDuration = Duration(milliseconds: 100);

class UniversityBloc extends Bloc<UniversityEvent, UniversityState> {
  final UniversityRepository _repository;
  UniversityBloc(this._repository) : super(const UniversityState()) {
    on<UniversityFetched>(
      _onUniversitiesFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<FetchAllDevisionsOfUniversity>(_fetchAllDevisionsOfUniversity);
  }

  Future<void> _onUniversitiesFetched(
      UniversityFetched event, Emitter<UniversityState> emit) async {
    if (state.hasReachedMax) return;
    try {
      final universities = await _repository.getAllUniversities();
      final hasReachedMax = universities.length < _universitiesLimit;
      universities.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                universitiesStatus: Status.success,
                universities: List.of(state.universities)..addAll(universities),
                hasReachedMax: hasReachedMax,
              ),
            );
    } catch (e) {
      emit(state.copyWith(universitiesStatus: Status.failure));
    }
  }

  Future<void> _fetchAllDevisionsOfUniversity(
      FetchAllDevisionsOfUniversity event,
      Emitter<UniversityState> emit) async {
    try {
      final devisions = await _repository.getAllDivisions(event.university.uid);
      state.universities.remove(event.university);
      state.universities.insert(
        event.index!,
        event.university.copyWith(
          divisions: devisions,
        ),
      );
      emit(
        state.copyWith(
          devisionsStatus: Status.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(devisionsStatus: Status.failure));
    }
  }
}
