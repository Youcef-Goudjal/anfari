import 'package:anfari/core/extensions/extensions.dart';
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
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: university.divisions.length,
        itemBuilder: (context, index) {
          final devision = university.divisions[index];
          return SizedBox(
            height: 110.h,
            child: ElevatedButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
                side: const BorderSide(color: Colors.black),
              )),
              onPressed: () {},
              child: Center(
                child: Text(
                  devision.name,
                  style: context.textTheme.headline1!.copyWith(
                    fontSize: 12.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
