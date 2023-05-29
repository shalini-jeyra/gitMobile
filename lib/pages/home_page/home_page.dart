import 'package:flutter/material.dart';
import 'package:git_mobile/styles/styles.dart';

import '../pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _appBar(double height) => PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              SizedBox(
                height: height + 178,
                width: MediaQuery.of(context).size.width,
                child: AppBar(
                  backgroundColor: Color.fromARGB(255, 112, 108, 255),
                  leading: Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                  title: Text(
                    'Github',
                    style: HeaderFonts.primaryText,
                  ),
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Transform.rotate(
                        angle: 0.3,
                        child: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 120.0,
                left: 20.0,
                right: 20.0,
                child: Material(
                  elevation: 1,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: Container(
                    height: 108,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: ListTile(
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
                        child: const Icon(Icons.person),
                      ),
                      title: Text(
                        'John Doe',
                        style: TextFonts.primaryText,
                      ),
                      subtitle: Wrap(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(
                                255,
                                34,
                                204,
                                204,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: const Text('VTS'),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

    return Scaffold(
      
      appBar: _appBar(AppBar().preferredSize.height),
      drawer: Theme(
         data: Theme.of(context).copyWith(
      
      highlightColor: const Color.fromARGB(255, 158, 179, 199),
    ),
        child: Drawer(
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28.0, vertical: 36),
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                    child: const Icon(Icons.person),
                  ),
                  title: Text(
                    'Ash',
                    style: TextFonts.primaryText,
                  ),
                  subtitle: Wrap(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 212, 156, 33),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Text(
                          'VTS',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
              ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                  child: const Icon(Icons.person),
                ),
                title: const Text('Option 1'),
                onTap: () {},
              ),
              ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                  child: const Icon(Icons.person),
                ),
                title: const Text('Option 2'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 70.0,
          left: 16,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Projects',
              style: TextFonts.primaryText,
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 16,
                  );
                },
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 0.5,
                    color: Colors.white,
                    child: ListTile(
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
                        child: const Icon(Icons.person),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ash', style: TextFonts.primaryText),
                            const SizedBox(height: 6),
                            const Text('Subtitle'),
                          ],
                        ),
                      ),
                      trailing:const Icon(Icons.chevron_right),
                      onTap: () {
                       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
