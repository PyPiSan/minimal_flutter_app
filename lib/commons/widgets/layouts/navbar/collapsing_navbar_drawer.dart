import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/navbar/collapsing_list_tile.dart';
import 'package:minimal_flutter_app/model/collapsing_navbar_drawer_model.dart';
import 'package:minimal_flutter_app/utils/constants/colors.dart';

class CollapsingNavbarDrawer extends StatefulWidget {
  const CollapsingNavbarDrawer({super.key});

  @override
  State<CollapsingNavbarDrawer> createState() => _CollapsingNavbarDrawerState();
}

class _CollapsingNavbarDrawerState extends State<CollapsingNavbarDrawer>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = false;
  late AnimationController _animationController;
  late Animation<double> widthAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    widthAnimation =
        Tween<double>(begin: 250.0, end: 70.0).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, widget) => getWidget(context, widget));
  }

  Widget getWidget(context, widget) {
    return Container(
      width: widthAnimation.value,
      color: AppColors.dark,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 50.0,
          ),
          CollapsingListTile(
              title: 'Pypisan',
              icon: Icons.person,
              animationController: _animationController),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, counter) {
                return CollapsingListTile(
                    title: navigationItems[counter].title,
                    icon: navigationItems[counter].icon,
                    animationController: _animationController);
              },
              itemCount: navigationItems.length,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isCollapsed
                    ? _animationController.reverse()
                    : _animationController.forward();
                isCollapsed ? isCollapsed = false : isCollapsed = true;
              });
            },
            child: AnimatedIcon(
              icon: AnimatedIcons.close_menu,
              progress: _animationController,
              color: AppColors.white,
              size: 50.0,
            ),
          )
        ],
      ),
    );
  }
}
