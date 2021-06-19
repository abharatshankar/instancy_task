import 'package:flutter/material.dart';
import 'package:instancy_task/utils/util_methods.dart';

class CustomDropDown extends StatelessWidget {
  final value;
  final List<String> itemsList;
  final Color dropdownColor;
  final Function(dynamic value) onChanged;
  const CustomDropDown({
    @required this.value,
    @required this.itemsList,
    this.dropdownColor,
    @required this.onChanged,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 3,
        bottom: 3,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            2,
          ),
          border: Border.all(color: Color(0xffcacaca), width: 0.6),
          color: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              dropdownColor: dropdownColor,
              value: value,
              items: itemsList
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: spTextStyle(),
                        ),
                      ))
                  .toList(),
              onChanged: (value) => onChanged(value),
            ),
          ),
        ),
      ),
    );
  }
}
