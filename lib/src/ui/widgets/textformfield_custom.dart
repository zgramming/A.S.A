import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/global_provider.dart';
import '../../ui/variable/colors/color_pallete.dart';

class TextFormFieldCustom extends StatelessWidget {
  final IconData prefixIcon;
  final Widget suffixIcon;
  final String hintText;
  final String labelText;
  final String initialValue;
  final bool isPassword;
  final bool isEnabled;
  final bool isDone;
  final bool isValidatorEnable;
  final int minLines;
  final int maxLines;
  final double radius;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final Function(String) onFieldSubmitted;
  final Function(String) onSaved;
  TextFormFieldCustom({
    this.prefixIcon = Icons.supervised_user_circle,
    this.suffixIcon,
    this.initialValue,
    this.minLines,
    this.maxLines,
    this.focusNode,
    this.onFieldSubmitted,
    this.radius = 8,
    this.hintText = "Username",
    this.labelText = "Username",
    this.isDone = false,
    this.isPassword = false,
    this.isEnabled = true,
    this.isValidatorEnable = true,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    @required this.onSaved,
  });
  @override
  Widget build(BuildContext context) {
    final globalProvider = Provider.of<GlobalProvider>(context);

    return TextFormField(
      obscureText:
          (isPassword && globalProvider.obsecurePassword) ? true : false,
      enabled: isEnabled,
      initialValue: initialValue,
      minLines: minLines,
      maxLines: isPassword ? 1 : maxLines,
      decoration: InputDecoration(
        prefixIcon: isPassword
            ? Icon(Icons.lock)
            : Icon(
                prefixIcon,
                color: colorPallete.focusTextFormFieldTextDynamicColor(context),
              ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  globalProvider.obsecurePassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () => globalProvider.setObsecurePassword(
                  globalProvider.obsecurePassword,
                ),
              )
            : suffixIcon,
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
        contentPadding: const EdgeInsets.all(8.0),
        hintStyle: TextStyle(fontSize: 10),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorPallete.borderOutlineTextFormFieldDynamicColor(context),
          ),
        ),
        labelStyle: TextStyle(
          color: colorPallete.focusTextFormFieldTextDynamicColor(context),
        ),
      ),
      textInputAction: isDone ? TextInputAction.done : textInputAction,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      validator: isValidatorEnable
          ? (value) {
              if (value.isEmpty || value == null) {
                return "$labelText tidak boleh kosong ";
              }
              return null;
            }
          : null,
      onSaved: onSaved,
    );
  }
}
