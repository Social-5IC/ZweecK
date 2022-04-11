import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zweeck/view/home/home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> with TickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (HomeViewModel model) => model.init(),
      builder: (BuildContext context, HomeViewModel model, Widget? child) {
        return Scaffold(
          body: Center(
            child: Column(
              children: <Widget>[
                TabBar(
                  controller: /*_tabController*/,
                  tabs: const [
                    Tab(
                      text: 'Followed',
                    ),
                    Tab(
                      text: 'For You',
                    )
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      ChronometerHomePage(title: 'Chronometer'),
                      TimerHomePage(title: 'Timer'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
