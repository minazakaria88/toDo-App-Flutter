import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    required this.title,
    this.onTap,
    required this.validate,
    required this.iconData,
    required this.controller,
  });
  final String title;
  final Function ? onTap;
  final Function validate;
  final IconData iconData;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.purple,
            ),
          ),
          prefixIcon: Icon(iconData),
          label: Text(
            title,
          ),
        ),
        validator: (value) {
          return validate(value);
        },
        controller: controller,
        autocorrect: true,
        onTap: () {
          onTap!();
        },
      ),
    );
  }
}
