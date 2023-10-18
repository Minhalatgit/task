import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LabeledEditText extends StatelessWidget {
  final int? maxLines;
  final bool obscure;
  final bool? setEnable, differDisabledColor;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onIconPressed;
  final VoidCallback? onLeadingIconPressed;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? hintText, labelText, value, suffixIcon, leadingIcon;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType? textInputType;
  final FormFieldSetter<String>? onSaved;
  final FocusNode? currentFocus, nextFocus;
  final IconData? leadingIconData;
  final TextEditingController controller;
  final TextStyle? textStyle;
  BuildContext? _context;
  final InputDecoration? inputDecoration;
  final bool autofocus;
  final bool isSearch;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final AutovalidateMode autoValidateMode;
  final void Function()? onTap;
  final bool onTapOutsideCloseKeyboard;

  LabeledEditText({
    required this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onSaved,
    this.onIconPressed,
    this.onLeadingIconPressed,
    this.textInputAction = TextInputAction.next,
    this.inputFormatter,
    this.validator,
    this.value,
    this.leadingIconData,
    this.leadingIcon,
    this.suffixIcon,
    this.hintText,
    this.labelText,
    this.setEnable,
    this.nextFocus,
    this.currentFocus,
    this.textInputType,
    this.maxLines = 1,
    this.obscure = false,
    this.textStyle,
    this.inputDecoration,
    this.differDisabledColor = false,
    this.autofocus = false,
    this.isSearch = false,
    this.readOnly = false,
    this.onTapOutsideCloseKeyboard = true,
    this.textCapitalization = TextCapitalization.none,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _context = context;
    return TextFormField(
      onTapOutside: onTapOutsideCloseKeyboard ? (event) => FocusScope.of(context).unfocus() : null,
      onTap: onTap,
      textCapitalization: textCapitalization,
      enabled: setEnable,
      focusNode: currentFocus,
      textInputAction: textInputAction,
      controller: controller,
      inputFormatters: inputFormatter,
      keyboardType: textInputType,
      textAlignVertical: TextAlignVertical.center,
      maxLines: maxLines,
      obscureText: obscure,
      autofocus: autofocus,
      onChanged: onChanged,
      readOnly: readOnly,
      validator: validator,
      autovalidateMode: autoValidateMode,
      style: textStyle,
      decoration: inputDecoration,
      onEditingComplete: () {
        _fieldFocusChange(currentFocus!, nextFocus);
      },
      onFieldSubmitted: isSearch
          ? (value) {
              if (onSubmitted != null) {
                onSubmitted!(value);
              }
              FocusScope.of(context).requestFocus(FocusNode());
            }
          : (value) {
              _fieldFocusChange(currentFocus!, nextFocus);
            },
    );
  }

  _fieldFocusChange(FocusNode currentFocus, FocusNode? nextFocus) {
    currentFocus.unfocus();
    if (nextFocus != null) FocusScope.of(_context!).requestFocus(nextFocus);
  }
}
