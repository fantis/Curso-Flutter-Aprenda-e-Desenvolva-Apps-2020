import 'package:flutter/material.dart';
import 'package:expenses/components/adaptativeButton.dart';
import 'package:expenses/components/adaptativeTextField.dart';
import 'package:expenses/components/adaptativeDatePicker.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
              AdaptativeTextField(
                label: 'Título',
                onSubmitted: (_) => _submitForm(),
                titleController: _titleController,
              ),
              AdaptativeTextField(
                label: 'Valor (R\$)',
                onSubmitted: (_) => _submitForm(),
                titleController: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              AdaptativeDatePicker(
                  selectedDate: this._selectedDate,
                  onDateChanged: (newDate) {
                    setState(() {
                      this._selectedDate = newDate;
                    });
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AdaptativeButton(
                    label: 'Nova Transação',
                    onPressed: _submitForm,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
