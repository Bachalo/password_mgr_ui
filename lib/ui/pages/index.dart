//

import 'dart:js' as js;
import 'package:chrome_extension/services/services.dart';
import 'package:chrome_extension/services/models/search_model.dart';
import 'package:chrome_extension/ui/components/addnew_popup.dart';
import 'package:chrome_extension/ui/components/entry_card.dart';
import 'package:chrome_extension/ui/scheme.dart';
import 'package:flutter/material.dart';

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
    _userFuture = _getFuture();
  }

  Future<List<SearchResult>> _getFuture() async {
    return Services.search(url["currentURL"]);
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _userFuture = _getFuture();
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
            onPressed: () {},
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
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  AddNewPopup(url: url["currentURL"]));
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
                return const Center(child: CircularProgressIndicator());
              } else {
                final List<SearchResult> _futureList = snapshot.data;
                return ListView.builder(
                  itemCount: _futureList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return EntryCard(
                        id: _futureList[index].id,
                        appIcon: Icons.person,
                        appName: "appName",
                        email: _futureList[index].email,
                        password: _futureList[index].password,
                        url: "https://randomurl.com",
                        timeFromAddded: "timeFromAddded");
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
  final data = Services.search("url");

  @override
  List<Widget> buildActions(BuildContext context) {
    // action for appBar

    return <Widget>[
      IconButton(onPressed: () {}, icon: const Icon(Icons.clear))
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
    Future<List<SearchResult>> _refresh() async {
      await Future.delayed(const Duration(seconds: 1));
      return Services.search(query);
    }

    final _userFuture = _refresh();

    return FutureBuilder(
      future: _userFuture,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final List<SearchResult> _futureList = snapshot.data;
          return ListView.builder(
            itemCount: _futureList.length,
            itemBuilder: (BuildContext context, int index) {
              return EntryCard(
                  id: _futureList[index].id,
                  appIcon: Icons.person,
                  appName: "appName",
                  email: _futureList[index].email,
                  password: _futureList[index].password,
                  url: "https://randomurl.com",
                  timeFromAddded: "timeFromAddded");
            },
          );
        }
      },
    );
  }
}
