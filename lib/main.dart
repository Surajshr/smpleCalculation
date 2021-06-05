import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Example",
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.image),
          title: Text('This is example'),
        ),
        body: getListView(),
      ),
    ),
  );
}

List<String> getListElements() {
  var items = List<String>.generate(100, (counter) => "Items $counter");
  return items;
}

Widget getListView() {
  var listItems = getListElements();
  var listView = ListView.builder(itemBuilder: (context, index) {
    return ListTile(
      leading: Icon(Icons.arrow_right),
      title: Text(listItems[index]),
      onTap: () {
        debugPrint('you tapped $listItems[index]');
      },
    );
  });
  return listView;
}
