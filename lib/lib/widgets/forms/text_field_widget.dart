import 'package:flutter/material.dart';
import 'package:jobapp/configs/ui_configs.dart';
import 'package:jobapp/lib/forms/field.dart' as fields;
import 'package:jobapp/lib/widgets/forms/field_widget.dart';

class TextFieldWidget extends FieldWidget<String> {
  final bool emptyAsNull;
  final TextEditingController _controller = TextEditingController();
  final IconData? iconData;
  final bool obsecureText;

  TextFieldWidget(
      {Key? key,
      required fields.Field<String> field,
      Function(String)? onChanged,
      this.emptyAsNull = true,
      this.obsecureText = false,
      this.iconData})
      : super(key: key, field: field, onChanged: onChanged);

  @override
  Widget constructInputNode(String? value, Function(String) callback) {
    if (_controller.text != value) {
      _controller.text = value ?? "";
    }
    // _controller.text = value ?? "";
    return TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            fillColor: ColorsConfigs.light,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(SpacingConfigs.spacing3)),
            prefixIcon: Icon(iconData),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorsConfigs.primary),
                borderRadius: BorderRadius.circular(
                  SpacingConfigs.spacing3,
                ))),
        onChanged: callback,
        obscureText: obsecureText,
        controller: _controller);
  }
}
