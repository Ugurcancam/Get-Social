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
          title: const Text(
            'Etkinliklerim',
            style: TextStyle(fontSize: 16),
          ),
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
                  color: Colors.green.shade100,
                ),
                child: const TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black54,
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
