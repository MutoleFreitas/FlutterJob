import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vid_viewr/config/auth.dart';
import '/config/AppScrollBehavior.dart';
import '/views/profile.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '/views/pages/homePage.dart';

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

enum _MenuValues {
  profile,
  logout,
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.none;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = -1.0;
  final AuthService _auth = AuthService();
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 600;
    return Scaffold(
      appBar: myAppBar(size),
      bottomNavigationBar: GNav(
          selectedIndex: _selectedIndex,
          onTabChange: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          hoverColor: Colors.grey.shade700, // tab button hover color
          haptic: true, // haptic feedback
          tabBorderRadius: 15,
          tabActiveBorder:
              Border.all(color: Colors.black, width: 1), // tab button border
          tabBorder:
              Border.all(color: Colors.grey, width: 1), // tab button border

          curve: Curves.easeOutExpo, // tab animation curves
          duration: Duration(milliseconds: 200), // tab animation duration
          gap: 8, // the tab button gap between icon and text
          color: Colors.grey[800], // unselected icon color

          iconSize: 24, // tab button icon size

          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: 10), // navigation bar padding
          tabs: isSmallScreen
              ? [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.book,
                    text: 'Likes',
                  ),
                  GButton(
                    icon: CupertinoIcons.compass_fill,
                    text: 'Search',
                  ),
                  GButton(
                    icon: CupertinoIcons.gear_solid,
                    text: 'Profile',
                  )
                ]
              : []),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          isSmallScreen ? Container() : sideBar(),
          HomePage(),
        ],
      ),
    );
  }

  NavigationRail sideBar() {
    return NavigationRail(
      backgroundColor: Colors.white,
      selectedIndex: _selectedIndex,
      groupAlignment: groupAlignment,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      destinations: const <NavigationRailDestination>[
        NavigationRailDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: Text('Home'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.bookmark_border),
          selectedIcon: Icon(Icons.book),
          label: Text('Favoritos'),
        ),
        NavigationRailDestination(
          icon: Icon(CupertinoIcons.compass),
          selectedIcon: Icon(CupertinoIcons.compass_fill),
          label: Text('Livros'),
        ),
        NavigationRailDestination(
          icon: Icon(CupertinoIcons.gear),
          selectedIcon: Icon(CupertinoIcons.gear_solid),
          label: Text('Definicoes'),
        ),
      ],
    );
  }

  AppBar myAppBar(Size size) {
    return AppBar(
      backgroundColor: Colors.white,
      actions: [
        ElevatedButton(
            onPressed: () async {
              await _auth.signOut();
            },
            child: Text("Logout")),
      ],
    );
  }
}
