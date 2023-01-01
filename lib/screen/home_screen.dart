import 'package:flutter/material.dart';
import 'package:quick_translate/model/model.dart';
import 'package:quick_translate/services/services.dart';
import 'screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quick ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
              ),
            ),
            Text(
              'Translate',
              style: TextStyle(
                color: Color(0xFFFF865E),
                fontSize: 25.0,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              PositionedContainer(
                color: Color(0xFF9685FF),
                isBool: true,
              ),
              PositionedContainer(
                color: Color(0xFFA2D2FF),
                isBool: false,
              ),
            ],
          ),
          PositionedCircle(
            top: height * 0.165,
            color: Color(0xFFFF865E),
            iconData: Icons.sync_rounded,
            onPressed: () {
              final ref = context.read<ProviderService>();

              setState(() {
                String temp = ref.selectedValue1;
                ref.selectedValue1 = ref.selectedValue2;
                ref.selectedValue2 = temp;
              });
            },
          ),
          Positioned(
            bottom: height * 0.25,
            child: Text(
              'Translation now \n in your hand',
              style: TextStyle(
                fontSize: 38.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          PositionedCircle(
            top: height * 0.68,
            color: Color(0xFFFF865E),
            iconData: Icons.arrow_forward,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TranslateScreen(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
