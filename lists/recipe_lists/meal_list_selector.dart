import 'package:flutter/material.dart';
import 'breakfast_list_first.dart';
import 'dinner_list_first.dart';
import 'lunch_list_first.dart';

class MealListSelector extends StatelessWidget {
  final String timeOfDay; // Add a String parameter to receive the time of day

  const MealListSelector({Key? key, required this.timeOfDay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (timeOfDay == 'Morning') {
      return BreakfastListFirst();
    } else if (timeOfDay == 'Lunch') {
      return LunchListFirst();
    } else {
      return DinnerListFirst();
    }
  }
}
