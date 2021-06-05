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
void showSnackBar(BuildContext context , String item){
  var snackBar = SnackBar(
      content: Text("You just Tapped $item"),
    action: SnackBarAction(
      label: "UNDO",
      onPressed:(){
        debugPrint("Performing dummy UNDO operation");
      }
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
        showSnackBar(context, listItems[index]);
      },
    );
  });
  return listView;
}
