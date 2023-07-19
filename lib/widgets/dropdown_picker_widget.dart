import 'package:flutter/material.dart';

class DropdownPickerWidget extends StatefulWidget {
  final String title;
  final String value;
  final List<String> options;
  final Function(String) onChanged;

  const DropdownPickerWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.options,
    required this.onChanged,
  }) : super(key: key);

  @override
  _DropdownPickerWidgetState createState() => _DropdownPickerWidgetState();
}

class _DropdownPickerWidgetState extends State<DropdownPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showOptionsDialog();
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(widget.value),
      ),
    );
  }

  void _showOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(widget.title),
          children: widget.options.map((option) {
            return SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, option);
              },
              child: Text(option),
            );
          }).toList(),
        );
      },
    ).then((selectedOption) {
      if (selectedOption != null) {
        widget.onChanged(selectedOption);
      }
    });
  }
}
