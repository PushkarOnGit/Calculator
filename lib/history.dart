// history.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'history_model.dart';
import 'home_page.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                icon: Icon(Icons.arrow_back_outlined)),
            Text(
              'History',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ],
        ),
      ),
      body: Consumer<HistoryModel>(
        builder: (context, historyModel, _) {
          return ListView.builder(
            itemCount: historyModel.historyList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(historyModel.historyList[index]),
              );
            },
          );
        },
      ),
    );
  }
}
