import 'package:buddies_app/const.dart';
import 'package:flutter/material.dart';

class SimplePetCard extends StatelessWidget {
  final String name;
  final String type;
  final String breed;
  final String size;
  const SimplePetCard(
      {super.key,
      required this.name,
      required this.type,
      required this.breed,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          decoration: BoxDecoration(
              color: inputGrey, borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60.0,
                height: 60.0,
                decoration: const BoxDecoration(
                    color: primaryColor, shape: BoxShape.circle),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: '$name ',
                          style: Font.titleStyle,
                          children: <TextSpan>[
                            TextSpan(
                                text: '$type  $breed', style: Font.textStyle)
                          ]),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text('Raza $size', style: Font.textStyle)
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
