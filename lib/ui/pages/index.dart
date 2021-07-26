//

import 'dart:js' as js;
import 'package:chrome_extension/services/provider.dart';
import 'package:chrome_extension/services/services.dart';
import 'package:chrome_extension/services/models/search_model.dart';
import 'package:chrome_extension/ui/components/entry_card.dart';
import 'package:chrome_extension/ui/pages/new_entry.dart';
import 'package:chrome_extension/ui/pages/settings.dart';
import 'package:chrome_extension/ui/scheme.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  String text = "CTRL-C";
  dynamic url = js.JsObject.fromBrowserObject(js.context['state']);

  late Future<List<SearchResult>> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = Services.returnAll();
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _userFuture = Services.returnAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final url = js.JsObject.fromBrowserObject(js.context['state']);
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 72.0,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Row(
          children: const [
            Text(
              "PASSWORD_MGR",
              style: TextStyle(
                color: kPrimaryDark,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
            icon: const Icon(
              Icons.search,
              size: 36.0,
              color: kSecondaryDark,
            ),
          ),
          const SizedBox(
            width: 9.0,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: kAnimationDuration,
                      curve: Curves.easeInOutCubic,
                      child: const SettingsPage(),
                      type: PageTransitionType.rightToLeftWithFade));
            },
            icon: const Icon(
              Icons.settings,
              size: 36.0,
              color: kSecondaryDark,
            ),
          ),
          const SizedBox(
            width: 18.0,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.withOpacity(0.1),
        hoverColor: Colors.grey.withOpacity(0.2),
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              curve: Curves.easeInOutCubic,
              duration: kAnimationDuration,
              type: PageTransitionType.fade,
              child: const NewEntry(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
          color: kSecondaryDark,
        ),
        child: RefreshIndicator(
          color: Colors.black,
          backgroundColor: kPrimaryDark,
          onRefresh: () => _refresh(),
          child: FutureBuilder(
            future: _userFuture,
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                ));
              } else {
                final List<SearchResult> _futureList = snapshot.data;
                return ListView.builder(
                  itemCount: _futureList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return EntryCard(
                      id: _futureList[index].id,
                      appIcon: Icons.person,
                      appName: _futureList[index].appNAme,
                      email: _futureList[index].email,
                      password: _futureList[index].password,
                      url: _futureList[index].urlAddress,
                      appTag: _futureList[index].dateAdded,
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final data = Services.returnAll();

  @override
  List<Widget> buildActions(BuildContext context) {
    // action for appBar

    return <Widget>[
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left the app bar
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show result based on the selection
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ChangeNotifierProvider<PasswordProvider>(
      create: (context) => PasswordProvider(),
      child: Consumer<PasswordProvider>(
        builder: (context, provider, child) {
          provider.updatePasswordList();
          var suggestionList = searchThroughList(provider.passwordList, query);
          return ListView.builder(
            itemCount: suggestionList.length,
            itemBuilder: (BuildContext context, int index) {
              return EntryCard(
                id: suggestionList[index].id,
                appIcon: Icons.person,
                appName: suggestionList[index].appNAme,
                email: suggestionList[index].email,
                password: suggestionList[index].password,
                url: suggestionList[index].urlAddress,
                appTag: suggestionList[index].appTag,
              );
            },
          );
        },
      ),
    );
  }
}

List<SearchResult> searchThroughList(List<SearchResult> data, String query) {
  return data
      .where((p) =>
          p.appNAme.startsWith(query) ||
          p.email.startsWith(query) ||
          p.password.startsWith(query) ||
          p.urlAddress.startsWith(query) ||
          p.appTag.startsWith(query))
      .toList();
}
