import 'package:flutter/material.dart';
import 'package:swapp2/components/styles.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;

  final String label;

  final Function onChanged;
  final int maxLines;

 TextInputType keyboardType;

 CustomTextField(
      {Key? key,
      this.keyboardType =TextInputType.text ,
      required this.label,
      this.hint,
      required this.onChanged,
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization:TextCapitalization.sentences,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: inputDecoration.copyWith(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: label,
          floatingLabelStyle: productValueStyle.copyWith(
              fontSize: 17, fontWeight: FontWeight.bold),
        ),
        onChanged: (value) => onChanged(value));
  }
}
