import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/services.dart';

class AdaptativeTextField extends StatelessWidget {
  final String label;
  final Function(String) onSubmitted;
  final TextEditingController titleController;
  final TextInputType keyboardType;

  AdaptativeTextField({
    this.label,
    this.onSubmitted,
    this.titleController,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: CupertinoTextField(
              controller: this.titleController,
              keyboardType: this.keyboardType,
              onSubmitted: this.onSubmitted,
              placeholder: this.label,
              padding: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 12,
              ),
            ),
          )
        : TextField(
            controller: this.titleController,
            keyboardType: this.keyboardType,
            onSubmitted: this.onSubmitted,
            decoration: InputDecoration(
              labelText: this.label,
            ),
          );
  }
}
