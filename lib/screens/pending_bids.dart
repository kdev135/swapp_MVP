import 'package:flutter/material.dart';

class PendingBids extends StatelessWidget {
  const PendingBids({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(tabs: [
              Tab(
                text: 'My bids',
              ),
              Tab(
                text: 'Proposed bids',
              )
            ]),
          ),
          body: TabBarView(
            children: [
              ListView(
                children: const [
                  Text('My bid'),
                  Text('bid'),
                  Text('data'),
                ],
              ),
              ListView(
                children: [
                  
                   Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                      Icon(Icons.warning),
                      Text('No products here')
                    ]),
                 
                ],
              )
            ],
          ),
        ));
  }
}
