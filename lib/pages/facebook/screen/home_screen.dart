import 'package:chatapp/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chatapp/components/components.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: Colors.white,
            title: const Text('facebook',
              style: TextStyle(color: Pallete.facebookBlue, fontSize: 28.0,
                  fontWeight: FontWeight.bold, letterSpacing: -1.2
              ),
            ),
            centerTitle: false,
            floating: true,
            actions: [
              CircleButton(icon: Icons.search,
                  iconSize: 30.0, onPress: () {}),
              CircleButton(icon: MdiIcons.facebookMessenger,
                  iconSize: 30.0, onPress: () {})
            ],
          )
        ],
      ),
    );
  }
}
