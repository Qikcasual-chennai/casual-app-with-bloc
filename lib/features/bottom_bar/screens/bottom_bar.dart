import 'dart:async';

import 'package:casual_app/common/widgets/custom_main_appbar.dart';
import 'package:casual_app/constants/utils.dart';
import 'package:casual_app/features/account/bloc/account_bloc.dart';
import 'package:casual_app/features/history/screens/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../account/screens/account_screen.dart';
import '../../home/screens/home_screen.dart';
import '../../jobs/screens/jobs_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  AccountBloc? accountBloc;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const JobsScreen(),
    const HistoryScreen(),
    const AccountScreen()
  ];

  _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _onItemTabbed(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    accountBloc = BlocProvider.of<AccountBloc>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<AccountBloc, AccountState>(
          listener: (context, state) {
            if(state is UnAuthorizedState){
              showFlushBar(context, state.msg, Colors.deepOrangeAccent);
              Timer(const Duration(seconds: 3), () {
                goToLogin(context);
              },);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: const CustomMainAppBar(),
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          children: _widgetOptions,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTabbed,
          selectedIconTheme: const IconThemeData(
            color: Color(0Xff111E28),
          ),
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 100,
          selectedItemColor: Colors.blueGrey,
          unselectedItemColor: const Color(0xFF526480),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Home",
                activeIcon: Icon(Icons.home)),
            BottomNavigationBarItem(
                icon: Icon(Icons.work_history_outlined),
                label: "Jobs",
                activeIcon: Icon(Icons.work_history)),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined),
              label: 'History',
              activeIcon: Icon(Icons.history)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box_outlined),
                label: "Account",
                activeIcon: Icon(Icons.account_box))
          ],
        ),
      ),
    );
  }
}
