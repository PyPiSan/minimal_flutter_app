import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/utils/theme/theme.dart';

class CollapsingListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final AnimationController animationController;

  const CollapsingListTile(
      {super.key,
      required this.title,
      required this.icon,
      required this.animationController});

  @override
  State<CollapsingListTile> createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
  late Animation<double> widthAnimation;
  @override
  void initState() {
    super.initState();
    widthAnimation = Tween<double>(begin: 250.0, end: 70.0)
        .animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        children: <Widget>[
          Icon(
            widget.icon,
            color: Colors.white30,
            size: 35.0,
          ),
          const SizedBox(
            width: 10.0,
          ),
          (widthAnimation.value > 200)
              ? Text(
                  widget.title,
                  style: AppTheme.collapsingNavBarDrawerDefaultTextStyle,
                )
              : Container()
        ],
      ),
    );
  }
}
