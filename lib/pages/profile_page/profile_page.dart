import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class ProfilePage extends StatelessWidget {
  final String repoName;
  final String ownerName;
  final String ownerIconUrl;
  const ProfilePage({super.key,required this.repoName, required this.ownerName, required this.ownerIconUrl});

  @override
  Widget build(BuildContext context) {
    _appBar(double height) => PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, height + 120),
          child: SizedBox(
            height: height + 178,
            width: MediaQuery.of(context).size.width,
            child: AppBar(
              backgroundColor: const Color.fromARGB(255, 112, 108, 255),
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              centerTitle: true,
              title: Text(
                'Project',
                style: HeaderFonts.primaryText,
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: const Color.fromARGB(
                              255,
                              237,
                              237,
                              255,
                            ),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        'Heavenly',
                        style: HeaderFonts.primaryText,
                      ),
                      subtitle: Text(
                        'Rajeshs',
                        style: HeaderFonts.secondaryText,
                      ),
                      onTap: () {},
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Last Update : 24/04/2023',
                        style: HeaderFonts.secondaryText,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );

    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                tabs: const [
                  Tab(
                    text: 'Branch 1',
                  ),
                  Tab(
                    text: 'Branch 2',
                  ),
                  Tab(
                    text: 'Branch 3',
                  ),
                ],
                 indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(43.0),
                    color: const Color.fromARGB(255, 39, 39, 74,),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 6),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                ),
              
               Expanded(
                child: TabBarView(
                  children: [
                  ListView.builder(itemBuilder: (BuildContext context,int index){
                    return ListTile(
                      leading: const Icon(
                        Icons.folder,
                        size: 40,
                        color: Colors.orange,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login Flow',
                            style: TextFonts.primaryText
                          ),
                          const Text(
                        '17/05/23 09:30AM',
                        
                      ),
                        ],
                      ),
                      subtitle: const Row(
                        children: [
                          Icon(Icons.person_pin,color: Colors.green,),
                          Text(
                            'Pravin kumar',
                            
                          ),
                        ],
                      ),
                      onTap: () {},
                    );
                  },itemCount: 7,),
                    const Center(
                      child: Text('Tab 2 Content'),
                    ),
                    const Center(
                      child: Text('Tab 3 Content'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
