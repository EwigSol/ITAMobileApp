// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:italms/utils/CustomAppBarWidget.dart';
import 'package:italms/utils/FunctinsData.dart';
import 'package:italms/utils/widget/Routine_row.dart';

// ignore: must_be_immutable
class Routine extends StatelessWidget {
  List<String> weeks = AppFunction.weeks;
  String id;

  Routine({this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Routine'),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: weeks.length,
          itemBuilder: (context, index) {
            return RoutineRow(
              title: weeks[index],
              id: id,
            );
          },
        ),
      ),
    );
  }
}
