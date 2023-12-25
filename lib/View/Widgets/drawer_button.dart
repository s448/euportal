import 'package:flutter/material.dart';

import '../../Core/Constant/image_path.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(ctx) {
    return Builder(
      builder: (context) => IconButton(
        icon: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(drawerIc),
        ),
        onPressed: () => Scaffold.of(context).openEndDrawer(),
      ),
    );
  }
}
