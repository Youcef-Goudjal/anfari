import 'package:anfari/core/extensions/extensions.dart';
import 'package:anfari/core/manager/theme/theme_manager.dart';
import 'package:anfari/features/university/bloc/university_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:university_repository/university_repository.dart';

class UniversityPage extends StatelessWidget {
  final int index;
  final University university;
  const UniversityPage({
    super.key,
    required this.university,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UniversityBloc>(context)
        .add(FetchAllDevisionsOfUniversity(university, index));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          university.name,
          style: context.textTheme.headline1!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocBuilder<UniversityBloc, UniversityState>(
        builder: (context, state) {
          if (state.devisionsStatus.isInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.devisionsStatus.isFailure) {
            return const Center(
              child: Text("Ooops !! Somthing went wronge !!"),
            );
          }

          return Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.w,
                mainAxisSpacing: 20.h,
              ),
              itemCount: university.divisions.length,
              itemBuilder: (context, index) {
                final devision = university.divisions[index];
                return SizedBox(
                  height: 110.h,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          side: const BorderSide(color: Colors.black, width: 2),
                        )),
                    onPressed: () {},
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.translate,
                            color: ThemeManager.primaryColor,
                            size: 70.h,
                          ),
                          10.h.heightBox,
                          Text(
                            devision.name,
                            style: context.textTheme.headline1!.copyWith(
                              fontSize: 12.sp,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
