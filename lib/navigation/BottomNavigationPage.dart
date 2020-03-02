import 'package:flutter/material.dart';
import 'package:isoundboard/channels/ChannelsPage.dart';
import 'package:isoundboard/favourites/FavouritesPage.dart';
import 'package:isoundboard/ratings/RatingsPage.dart';
import 'package:isoundboard/settings/SettingsPage.dart';
import 'package:isoundboard/submit/SubmitSoundPage.dart';

class BottomNavigationPage extends StatefulWidget {
  @override
  BottomNavigationPageState createState() => BottomNavigationPageState();
}

class BottomNavigationPageState extends State<BottomNavigationPage> {
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static ChannelsPage channelsPage = ChannelsPage(); //HomePage();

  static FavouritesPage favouritesPage = FavouritesPage();
  static RatingsPage ratingsPage = RatingsPage();
  static SubmitSoundPage submitSoundPage = SubmitSoundPage();
  static SettingsPage settingsPage = SettingsPage();

  static int selectedIndex = 0;
  List<BottomNavigationBarItem> bottomBarItems;
  List<Widget> pages;

  List<BottomNavigationBarItem> getBottomBarItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('2')),
      BottomNavigationBarItem(
          icon: Icon(Icons.library_music), title: Text('3')),
      BottomNavigationBarItem(icon: Icon(Icons.stars), title: Text('4')),
      BottomNavigationBarItem(
          icon: Icon(Icons.library_books), title: Text('5')),
      BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text('6'))
    ];
  }

  List<Widget> getPages() {
    return <Widget>[
      channelsPage,
      favouritesPage,
      ratingsPage,
      submitSoundPage,
      settingsPage
    ];
  }

  Widget buildOffstageNavigator(int index) {
    return Offstage(offstage: index != selectedIndex, child: pages[index]);
  }

  void onBottomBarItemClicked(int index) {
    if (!mounted) return;
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bottomBarItems = getBottomBarItems();
    pages = getPages();

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          buildOffstageNavigator(0),
          buildOffstageNavigator(1),
          buildOffstageNavigator(2),
          buildOffstageNavigator(3),
          buildOffstageNavigator(4),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: getBottomBarItems(),
        currentIndex: selectedIndex,
        onTap: onBottomBarItemClicked,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Theme.of(context).primaryColorDark,
        unselectedItemColor: Theme.of(context).primaryColorLight,
        selectedLabelStyle:
            TextStyle(color: Theme.of(context).primaryColorLight),
        unselectedLabelStyle:
            TextStyle(color: Theme.of(context).primaryColorDark),
      ),
    );
  }
}
