import 'package:flutter/material.dart';

import '../constants/colors.dart';

class MealFoodScheduleRow extends StatefulWidget {
  final Map mObj;
  final int index;
  final Function(String foodName, bool isChecked) onCheckboxChanged;

  const MealFoodScheduleRow(
      {super.key,
      required this.mObj,
      required this.index,
      required this.onCheckboxChanged});

  @override
  State<MealFoodScheduleRow> createState() => _MealFoodScheduleRowState();
}

class _MealFoodScheduleRowState extends State<MealFoodScheduleRow> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    color: widget.index % 2 == 0
                        ? TColor.primaryColor2.withOpacity(0.4)
                        : TColor.secondaryColor2.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: Image.asset(
                  widget.mObj["image"].toString(),
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.mObj["name"].toString(),
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    widget.mObj["time"].toString(),
                    style: TextStyle(
                      color: TColor.gray,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                  widget.onCheckboxChanged(widget.mObj["name"].toString(), isChecked);  // Call the callback function when the checkbox state changes
                }),
          ],
        ));
  }
}