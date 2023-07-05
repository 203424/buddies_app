import 'package:buddies_app/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title: BuddiesIcons.logoRounded(sizeIcon: 50.0, color: redColor),
          shadowColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.0,
                    children: [
                      botonServicio(
                          title: 'Paseo',
                          icon: BuddiesIcons.paseoIcon(
                              sizeIcon: 100.0, color: primaryColor)),
                      botonServicio(
                          title: 'Hospedaje',
                          icon: BuddiesIcons.serviciosIcon(
                              sizeIcon: 100.0, color: primaryColor)),
                    ],
                  ),
                ),
                const Text(
                  "Servicios en curso",
                  style: Font.titleStyle,
                ),
                enCursoWidget(),
                enCursoWidget(),
                const Text(
                  "Historial",
                  style: Font.titleStyle,
                ),
                historialWidget(),
                historialWidget(),
                historialWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget enCursoWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
          color: inputGrey, borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                    text: const TextSpan(
                        text: 'Kira ',
                        style: Font.titleStyle,
                        children: <TextSpan>[
                          TextSpan(text: '12:15', style: Font.textStyle)
                        ]),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text("Paseo individual - 1hr", style: Font.textStyle)
                ],
              ),
            ),
            Row(
              children: [
                const Text(
                  'Activo',
                  style: Font.textStyle,
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Container(
                  width: 14.0,
                  height: 14.0,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: greenColor),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget historialWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
          color: inputGrey, borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                    text: const TextSpan(
                        text: 'Kira',
                        style: Font.titleStyle,
                        children: <TextSpan>[
                          TextSpan(text: '  27 jun.', style: Font.textStyle)
                        ]),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text("Paseo individual - 1hr", style: Font.textStyle)
                ],
              ),
            ),
            Text(
              "\$34.00",
              style:
                  Font.numberStyle(fontSize: 25.0, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }

  Widget botonServicio({String? title, SvgPicture? icon}) {
    return Container(
      decoration: BoxDecoration(
          color: inputGrey,
          border: Border.all(color: secondaryColor, width: 3.0),
          borderRadius: BorderRadius.circular(10.0)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(
          title!,
          style: Font.titleStyle,
        ),
        icon!
      ]),
    );
  }
}
