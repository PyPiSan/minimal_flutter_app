import 'package:flutter/material.dart';
// import 'package:minimal_flutter_app/screens/chat_page.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _selectedIndex = 0;

  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = -1.0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Anime',
      style: optionStyle,
    ),
    Text(
      'Index 2: Drama',
      style: optionStyle,
    ),
    Text(
      'Index 3: Live',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  getDevice() {
    return MediaQuery.of(context).size.width <= 640 ? "Mobile" : "PC";
  }

  @override
  Widget build(BuildContext context) {
    // old Navigation bar
    // return Scaffold(
    //     body: ChatPage(),
    //     bottomNavigationBar: BottomNavigationBar(
    //       selectedItemColor: Colors.red,
    //       unselectedItemColor: Colors.grey.shade600,
    //       selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
    //       unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
    //       type: BottomNavigationBarType.fixed,
    //       items: const <BottomNavigationBarItem>[
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.message),
    //           label: "Chats",
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.group_work),
    //           label: "Channels",
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.account_box),
    //           label: "Profile",
    //         ),
    //       ],
    //     )
    //     );

    // Different Version of Bottom Navigation
    // final ThemeData theme = Theme.of(context);
    // return Scaffold(
    //   bottomNavigationBar: NavigationBar(
    //     // onDestinationSelected: (int index) {
    //     //   setState(() {
    //     //     currentPageIndex = index;
    //     //   });
    //     // },
    //     indicatorColor: Colors.amber,
    //     selectedIndex: currentPageIndex,
    //     destinations: const <Widget>[
    //       NavigationDestination(
    //         selectedIcon: Icon(Icons.home),
    //         icon: Icon(Icons.home_outlined),
    //         label: 'Home',
    //       ),
    //       NavigationDestination(
    //         icon: Badge(child: Icon(Icons.notifications_sharp)),
    //         label: 'Notifications',
    //       ),
    //       NavigationDestination(
    //         icon: Badge(
    //           label: Text('2'),
    //           child: Icon(Icons.messenger_sharp),
    //         ),
    //         label: 'Messages',
    //       ),
    //     ],
    //   ),
    //   body: <Widget>[
    //     /// Home page
    //     Card(
    //       shadowColor: Colors.transparent,
    //       margin: const EdgeInsets.all(8.0),
    //       child: SizedBox.expand(
    //         child: Center(
    //           child: Text(
    //             'Home page',
    //             style: theme.textTheme.titleLarge,
    //           ),
    //         ),
    //       ),
    //     ),

    //     /// Notifications page
    //     const Padding(
    //       padding: EdgeInsets.all(8.0),
    //       child: Column(
    //         children: <Widget>[
    //           Card(
    //             child: ListTile(
    //               leading: Icon(Icons.notifications_sharp),
    //               title: Text('Notification 1'),
    //               subtitle: Text('This is a notification'),
    //             ),
    //           ),
    //           Card(
    //             child: ListTile(
    //               leading: Icon(Icons.notifications_sharp),
    //               title: Text('Notification 2'),
    //               subtitle: Text('This is a notification'),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),

    //     /// Messages page
    //     ListView.builder(
    //       reverse: true,
    //       itemCount: 2,
    //       itemBuilder: (BuildContext context, int index) {
    //         if (index == 0) {
    //           return Align(
    //             alignment: Alignment.centerRight,
    //             child: Container(
    //               margin: const EdgeInsets.all(8.0),
    //               padding: const EdgeInsets.all(8.0),
    //               decoration: BoxDecoration(
    //                 color: theme.colorScheme.primary,
    //                 borderRadius: BorderRadius.circular(8.0),
    //               ),
    //               child: Text(
    //                 'Hello',
    //                 style: theme.textTheme.bodyLarge!
    //                     .copyWith(color: theme.colorScheme.onPrimary),
    //               ),
    //             ),
    //           );
    //         }
    //         return Align(
    //           alignment: Alignment.centerLeft,
    //           child: Container(
    //             margin: const EdgeInsets.all(8.0),
    //             padding: const EdgeInsets.all(8.0),
    //             decoration: BoxDecoration(
    //               color: theme.colorScheme.primary,
    //               borderRadius: BorderRadius.circular(8.0),
    //             ),
    //             child: Text(
    //               'Hi!',
    //               style: theme.textTheme.bodyLarge!
    //                   .copyWith(color: theme.colorScheme.onPrimary),
    //             ),
    //           ),
    //         );
    //       },
    //     ),
    //   ][currentPageIndex],
    // );

    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: getDevice() == "Mobile"
          ? BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.red,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Anime',
                  backgroundColor: Colors.green,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: 'Drama',
                  backgroundColor: Colors.purple,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Live',
                  backgroundColor: Colors.pink,
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[800],
              onTap: _onItemTapped,
            )
          : null,
      body: Row(
        children: [
          if (getDevice() == "PC")
            NavigationRail(
                selectedIndex: _selectedIndex,
                groupAlignment: groupAlignment,
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                labelType: labelType,
                destinations: const <NavigationRailDestination>[
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    selectedIcon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.business),
                    selectedIcon: Icon(Icons.business),
                    label: Text('Anime'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.school),
                    selectedIcon: Icon(Icons.school),
                    label: Text('Drama'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.settings),
                    selectedIcon: Icon(Icons.settings),
                    label: Text('Live'),
                  ),
                ]),
          Expanded(
            child: Column(
              children: <Widget>[_widgetOptions.elementAt(_selectedIndex)],
            ),
          )
        ],
      ),
    );
  }
}
