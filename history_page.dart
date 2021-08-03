import 'package:flutter/material.dart';
import 'package:fyp/constants.dart';
import 'package:fyp/state_management/database.dart';
import 'package:fyp/state_management/history.dart';

class HistoryPage extends StatefulWidget {
  final email;

  const HistoryPage({Key key, this.email}) : super(key: key);
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool isLoading = true;
  Widget body;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResults();
  }

  getResults() async {
    List<Widget> hists = [];

    List<History> histObjs = await Database().getHistory(email: widget.email);
    if (histObjs != null)
      for (var hist in histObjs) {
        hists.add(HistoryCard(
          date: hist.date,
          response: hist.response,
          email: hist.email,
        ));
      }
    body = ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: hists,
        )
      ],
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: pCol,
          title: Text('Previous Checkups'),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : body);
  }
}

class HistoryCard extends StatelessWidget {
  const HistoryCard({Key key, this.date, this.email, this.response})
      : super(key: key);
  final date, email, response;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width - 15,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  '$email',
                  style: TextStyle(
                      // color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 22),
                ),
                leading: Icon(
                  Icons.email,
                  color: Colors.red,
                ),
              ),
              ListTile(
                title: Text(
                  '$date',
                  style: TextStyle(
                      // color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 22),
                ),
                leading: Icon(
                  Icons.watch_later,
                  color: Colors.green,
                ),
              ),
              ListTile(
                title: Text(
                  '$response',
                  style: TextStyle(
// color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 22),
                ),
                leading: Icon(
                  Icons.check_circle,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
