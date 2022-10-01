import 'package:anfari/core/extensions/extensions.dart';
import 'package:anfari/features/university/views/university_page.dart';
import 'package:anfari/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/manager/theme/theme_manager.dart';
import '../../posts/views/widgets/widgets.dart';
import '../university.dart';

class UniversitiesList extends StatelessWidget {
  const UniversitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UniversityBloc(getIt())..add(UniversityFetched()),
      child: const _UniversityList(),
    );
  }
}

class _UniversityList extends StatefulWidget {
  const _UniversityList({
    Key? key,
  }) : super(key: key);

  @override
  State<_UniversityList> createState() => _UniversityListState();
}

class _UniversityListState extends State<_UniversityList> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) context.read<UniversityBloc>().add((UniversityFetched()));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: BlocBuilder<UniversityBloc, UniversityState>(
        builder: (_, state) {
          switch (state.universitiesStatus) {
            case Status.failure:
              return const Center(
                child: Text("failed to fetch posts"),
              );

            case Status.success:
              if (state.universities.isEmpty) {
                return const Center(
                  child: Text("no universities"),
                );
              } else {
                return ListView.separated(
                  controller: _scrollController,
                  padding: EdgeInsets.only(right: 17.w),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    if (index == 0) {
                      return Align(
                        alignment: Alignment.topCenter,
                        child: InkWell(
                          onTap: () {
                            //TODO:
                          },
                          child: Ink(
                            height: 50.w,
                            width: 50.w,
                            decoration: BoxDecoration(
                              color: ThemeManager.primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return index >= state.universities.length + 1
                          ? const BottomLoader()
                          : SizedBox(
                              width: 125.w,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (__) => BlocProvider.value(
                                        value: context.read<UniversityBloc>(),
                                        child: UniversityPage(
                                          university:
                                              state.universities[index - 1],
                                          index: index - 1,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xffD0EBE5).withOpacity(0.5),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(Icons.exit_to_app),
                                      ),
                                      6.h.heightBox,
                                      Text(
                                        state.universities[index - 1].name,
                                        style: context.textTheme.headline4!
                                            .copyWith(
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                      18.h.heightBox,
                                      Text(
                                        "1275 موضوع مع حله",
                                        style: context.textTheme.headline5!
                                            .copyWith(
                                          fontSize: 14.sp,
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                    }
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 20.w,
                    );
                  },
                  itemCount: state.hasReachedMax
                      ? state.universities.length + 1
                      : state.universities.length + 2,
                );
              }
            case Status.initial:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}
