import 'package:flutter/material.dart';
import 'package:quick_translate/services/services.dart';

class PositionedContainer extends StatefulWidget {
  PositionedContainer({
    super.key,
    this.color,
    this.isBool,
  });

  Color? color;
  bool? isBool;

  @override
  State<PositionedContainer> createState() => _PositionedContainerState();
}

class _PositionedContainerState extends State<PositionedContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 15.0,
      ),
      height: 130.0,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.all(Radius.circular(100.0)),
      ),
      child: Consumer<ProviderService>(
        builder: (context, provierData, child) {
          return DropdownButton(
            isExpanded: true,
            underline: Container(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 35.0,
            ),
            menuMaxHeight: MediaQuery.of(context).size.height / 2,
            value: widget.isBool!
                ? provierData.selectedValue1
                : provierData.selectedValue2,
            items: context.read<ProviderService>().languages.map((values) {
              return DropdownMenuItem(
                value: values,
                child: Center(
                  child: Text(
                    values,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                if (widget.isBool!) {
                  provierData.selectedValue1 = value!;
                } else {
                  provierData.selectedValue2 = value!;
                }
              });
            },
          );
        },
      ),
    );
  }
}
