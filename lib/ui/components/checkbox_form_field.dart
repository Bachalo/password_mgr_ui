import 'package:flutter/material.dart';

// import '../scheme.dart';

class CheckboxFormField extends FormField<bool> {
  final Widget title;
  final FormFieldSetter<bool> onSavedd;
  final FormFieldValidator<bool> validatorr;
  CheckboxFormField(
      {required this.title,
      required this.onSavedd,
      required this.validatorr,
      bool initialValue = false,
      bool autovalidate = false,
      Key? key})
      : super(
            key: key,
            onSaved: onSavedd,
            validator: validatorr,
            initialValue: initialValue,
            builder: (FormFieldState<bool> state) {
              return CheckboxListTile(
                dense: state.hasError,
                title: title,
                value: state.value,
                onChanged: state.didChange,
                subtitle: state.hasError
                    ? Builder(
                        builder: (BuildContext context) => Text(
                          checkIfNull(state.errorText),
                          style: TextStyle(color: Theme.of(context).errorColor),
                        ),
                      )
                    : null,
                controlAffinity: ListTileControlAffinity.leading,
              );
            });
}

checkIfNull(value) {
  if (value != null) {
    return value;
  } else {
    return "";
  }
}
