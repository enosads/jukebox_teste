import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppText extends StatelessWidget {
  String label;
  String hint;
  bool password;
  bool data;
  bool telefone;
  bool autofocus;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  FocusNode focusNode;
  FocusNode nextFocus;
  ValueChanged<String> onFieldSubmitted;
  Color color;
  bool readOnly;
  TextAlign textAlign;
  bool uppercase;
  bool cpf;
  Key formKey;
  bool cep;
  ValueChanged<String> onChanged;

  AppText({
    this.label,
    this.hint,
    this.focusNode,
    this.controller,
    this.password = false,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.nextFocus,
    this.onFieldSubmitted,
    this.telefone = false,
    this.data = false,
    this.autofocus = false,
    this.color,
    this.readOnly = false,
    this.textAlign,
    this.uppercase = false,
    this.cpf = false,
    this.onChanged,
    this.formKey,
    this.cep = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: telefone
          ? [
              MaskTextInputFormatter(
                  mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')})
            ]
          : data
              ? [
                  MaskTextInputFormatter(
                      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')})
                ]
              : cpf
                  ? [
                      MaskTextInputFormatter(
                          mask: '###.###.###-##',
                          filter: {"#": RegExp(r'[0-9]')})
                    ]
                  : cep
                      ? [
                          MaskTextInputFormatter(
                              mask: '#####-###',
                              filter: {"#": RegExp(r'[0-9]')})
                        ]
                      : null,
      readOnly: readOnly,
      autofocus: autofocus,
      focusNode: focusNode,
      controller: controller,
      obscureText: password,
      validator: validator,
      keyboardType: keyboardType,
      onChanged: onChanged,
      key: formKey ?? null,
      textCapitalization:
          uppercase ? TextCapitalization.characters : TextCapitalization.none,
      textAlign: textAlign != null ? textAlign : TextAlign.start,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted != null
          ? onFieldSubmitted
          : (next) {
              if (nextFocus != null) {
                FocusScope.of(context).requestFocus(nextFocus);
              } else {
                FocusScope.of(context).unfocus();
              }
            },
      style: TextStyle(
        color: color != null ? color : null,
      ),
      decoration: InputDecoration(
        fillColor: Colors.red,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            32.0,
          ),
          borderSide: BorderSide(color: Colors.red),
        ),
        hintText: hint,
        labelText: label,
      ),
    );
  }
}
