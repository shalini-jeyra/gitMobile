import 'package:flutter/material.dart';
import 'package:git_mobile/services/provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../services/branch.dart';
import '../../styles/styles.dart';

class RepositoryViewPage extends StatelessWidget {
  final String repoName;
  final String ownerName;
  final String ownerIconUrl;
  const RepositoryViewPage(
      {super.key,
      required this.repoName,
      required this.ownerName,
      required this.ownerIconUrl});

  @override
  Widget build(BuildContext context) {
    final lastUpdateProvider =
        Provider.of<GitHubProvider>(context, listen: false);
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
                        child: ownerIconUrl != null
                            ? Image.network(ownerIconUrl)
                            :  Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        repoName,
                        style: HeaderFonts.primaryText,
                      ),
                      subtitle: Text(
                        ownerName,
                        style: HeaderFonts.secondaryText,
                      ),
                      onTap: () {},
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FutureBuilder(
                        future: lastUpdateProvider.fetchLastUpdate(
                            ownerName, repoName),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text('Error fetching last update date'),
                            );
                          } else {
                            final lastUpdate = lastUpdateProvider.lastUpdate!;
                            final formattedDate =
                                DateFormat('dd/MM/yyyy').format(lastUpdate);

                            return Text(
                              'Last Update: $formattedDate',
                              style: HeaderFonts.secondaryText,
                            );
                          }
                        },
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
        body: Consumer<GitHubProvider>(builder: (context, provider, _) {
    
          if (provider.branches == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: DefaultTabController(
              length: provider.branches!.length,
              child: Column(children: [
                TabBar(
                  isScrollable: true,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(43.0),
                    color: const Color.fromARGB(
                      255,
                      39,
                      39,
                      74,
                    ),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding:
                      const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: provider.branches!.map((branch) {
                    return Tab(
                      text: branch['name'],
                    );
                  }).toList(),
                ),
                Expanded(
                  child: TabBarView(
                    children: provider.branches!.map((branch) {
                      return ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          final commit =
                              provider.commitsByBranch[branch['name']]![index];
                          final commitMessage = commit['commit']['message'];
                          final commitTime =
                              commit['commit']['committer']['date'];
                          final authorName =
                              commit['commit']['committer']['name'];
                          return ListTile(
                            leading: const Icon(
                              Icons.folder,
                              size: 40,
                              color: Colors.orange,
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(commitMessage,
                                    style: TextFonts.primaryText),
                                Text(
                                  commitTime,
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Icon(
                                  Icons.person_pin,
                                  color: Colors.green,
                                ),
                                Text(
                                  authorName,
                                ),
                              ],
                            ),
                            onTap: () {},
                          );
                        },
                        itemCount:
                            provider.commitsByBranch[branch['name']]?.length ??
                                0,
                      );
                    }).toList(),
                  ),
                )
              ]),
            ),
          );
        }));
  }
}
