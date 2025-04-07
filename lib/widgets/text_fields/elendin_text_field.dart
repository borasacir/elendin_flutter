import 'package:elendin_flutter/constants/color_constants/color_constants.dart';
import 'package:elendin_flutter/constants/text_style_constants/text_style_constants.dart';
import 'package:flutter/material.dart';

class ElendinTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final Function(String)? onChanged;
  final String? label;
  const ElendinTextField(
      {super.key, this.textEditingController, this.onChanged, this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(6, 0, 0, 2),
            child: Text(
              label!,
              style: TextStyleConstants.textFieldLabel,
            ),
          ),
        TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorConstants.inputBorderGrayColor,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorConstants.inputBorderGrayColor,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorConstants.inputBorderGrayColor,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorConstants.inputBorderGrayColor,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
