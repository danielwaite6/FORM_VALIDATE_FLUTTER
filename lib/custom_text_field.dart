import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final IconData? icon;
  final bool obscureText;
  final Widget? suffix;
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;
  final void Function(String text)? onChanged;

  CustomTextField({
    Key? key,
    required this.label,
    this.icon,
    this.hint,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.obscureText = false,
    this.suffix,
  }) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          onSaved: onSaved,
          onChanged: onChanged,
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: suffix,
            labelText: label,
            hintText: hint,
            prefixIcon: icon == null ? null : Icon(icon),
            //suffixIcon: Icon(Icons.person),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(40.0),
              ),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            return Text(controller.text);
          },
        ),
      ],
    );
  }
}
