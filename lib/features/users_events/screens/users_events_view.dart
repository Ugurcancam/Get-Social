import 'package:codegen/codegen.dart';
import 'package:etkinlikapp/features/users_events/screens/tab_item.dart';
import 'package:etkinlikapp/features/users_events/screens/users_active_events.dart';
import 'package:etkinlikapp/features/users_events/screens/users_expired_events.dart';
import 'package:flutter/material.dart';

class UsersEventsView extends StatelessWidget {
  const UsersEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: ColorName.button,
                ),
                child: const TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: ColorName.secondary,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelColor: Colors.red,
                  unselectedLabelColor: Colors.red,
                  tabs: [
                    TabItem(title: 'Etkin', count: 10),
                    TabItem(title: 'Tamamlanan', count: 3),
                    //TabItem(title: 'Deleted', count: 1),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            UsersActiveEventsView(),
            UsersExpiredEventsView(),
          ],
        ),
      ),
    );
  }
}
