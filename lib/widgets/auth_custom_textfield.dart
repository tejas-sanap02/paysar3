import 'package:flutter/material.dart';

class AuthCustomTextfield extends StatelessWidget {
  final String title;
  final String hint;
  TextEditingController controller = TextEditingController();

  AuthCustomTextfield(
      {Key? key,
      required this.title,
      required this.controller,
      required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 8,
          ),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 18),
                hintText: hint,
                hintStyle: TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(
                        214, 214, 214, 1))), //rgba(214, 214, 214, 1)
          ),
        ),
      ],
    );
  }
}
