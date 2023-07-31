import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dropdown_picker_widget.dart';

class BreedPickerWidget extends StatefulWidget {
  final String petType;
  final String selectedBreed;
  final ValueChanged<String> onChanged;

  const BreedPickerWidget({
    Key? key,
    required this.petType,
    required this.selectedBreed,
    required this.onChanged,
  }) : super(key: key);

  @override
  _BreedPickerWidgetState createState() => _BreedPickerWidgetState();
}

class _BreedPickerWidgetState extends State<BreedPickerWidget> {
  List<String> _breeds = [''];
  String _selectedBreed = '';

  @override
  void initState() {
    super.initState();
    _loadBreeds();
  }

  @override
  void didUpdateWidget(covariant BreedPickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.petType != widget.petType) {
      _loadBreeds();
    }
    if (widget.selectedBreed != _selectedBreed) {
      setState(() {
        _selectedBreed =
            widget.selectedBreed.isNotEmpty ? widget.selectedBreed : _breeds[0];
      });
    }
  }

  Future<void> _loadBreeds() async {
    if (widget.petType == 'perro') {
      // Fetch dog breeds from API
      final response =
          await http.get(Uri.parse('https://dog.ceo/api/breeds/list/all'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _breeds = data['message'].keys.toList();
      }
    } else if (widget.petType == 'gato') {
      // Use a predefined list of cat breeds
      _breeds = [
        'Persian',
        'Siamese',
        'Maine Coon',
        'Ragdoll',
        'Bengal',
        'Sphynx',
        'British Shorthair',
      ];
    }

    setState(() {
      _selectedBreed =
          widget.selectedBreed.isNotEmpty ? widget.selectedBreed : _breeds[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownPickerWidget(
      title: 'Raza',
      value: widget.petType == '' ? 'Selecciona un tipo' : _selectedBreed,
      options: _breeds,
      onChanged: (newValue) {
        setState(() {
          _selectedBreed = newValue;
        });
        widget.onChanged(newValue);
      },
    );
  }
}
