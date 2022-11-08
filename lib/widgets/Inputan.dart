import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Inputan extends StatelessWidget {
  const Inputan({
    Key? key,
    required this.text1,
  }) : super(key: key);

  final TextEditingController text1;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: text1,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: InputDecoration(
          labelText: "Celcius", hintText: "Masukkan suhu dalam Celcius"),
    );
  }
}
