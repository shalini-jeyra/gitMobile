import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:git_mobile/services/project_list.dart';
import 'package:git_mobile/styles/styles.dart';
import 'package:provider/provider.dart';

import '../../services/provider.dart';
import '../pages.dart';

class HomePage extends StatelessWidget {
  final User user;
  const HomePage({Key? key,required this.user}) : super(key: key);

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
                        child:user.providerData[0].photoURL!=null?  Image.network(user.providerData[0].photoURL!):Icon(Icons.person),
                      ),
                      title: Text(
                        user.providerData[0].displayName ?? '',
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
                            child:  Text(user.providerData[0].email ?? ''),
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
              child: FutureBuilder(
                future: ProjectList().fetchGitHubProjects(context,Provider.of<GitHubProvider>(context).accessToken),
                builder: (context,snapshot) {
                   if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final repositories = snapshot.data!;

            
                  return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 16,
                      );
                    },
                    itemCount: repositories.length,
                    itemBuilder: (BuildContext context, int index) {
                       final repo = repositories[index];
                final String repoName = repo['name'];
                final String ownerName = repo['owner']['login'];
                final String ownerIconUrl = repo['owner']['avatar_url'];
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
                            child: ownerIconUrl!=null?Image.network(ownerIconUrl): Icon(Icons.person),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(repoName, style: TextFonts.primaryText),
                                const SizedBox(height: 6),
                                 Text(ownerName),
                              ],
                            ),
                          ),
                          trailing:const Icon(Icons.chevron_right),
                          onTap: () {
                           Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage(ownerIconUrl: ownerIconUrl, ownerName: ownerName, repoName: repoName,)),
      );
                          },
                        ),
                      );
                    },
                  );
                }else {
            return Center(child: Text('No repositories found.'));
          }
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
