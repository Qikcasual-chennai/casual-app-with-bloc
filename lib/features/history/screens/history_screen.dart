import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'History',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    // TextButton(
                    //   child: const Text('Load More'),
                    //   onPressed: () {
                    //     print('History');
                    //     Navigator.of(context).pushNamed('load_more_top_jobs');
                    //   },
                    // ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    HistoryExpandtile(),
                    const Divider(
                      height: 1,
                    ),
                    HistoryExpandtile(),
                    const Divider(
                      height: 1,
                    ),
                    HistoryExpandtile(),
                    const Divider(
                      height: 1,
                    ),
                    HistoryExpandtile(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryExpandtile extends StatelessWidget {
  const HistoryExpandtile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: EdgeInsets.only(
        top: 0.0,
        bottom: 0.0,
      ),
      leading: Icon(Icons.work_history_outlined),
      title: Text('Marriot restaurant'),
      subtitle: Text('Waiter '),
      trailing: Text('12-july-2023'),
      children: [
        Container(
          child: Row(
            children: [
              Expanded(
                child: ListTile(
                  leading: Icon(Icons.watch_later_outlined),
                  title: Text('In time :'),
                  subtitle: Text(
                    '8:00 AM',
                    style: GoogleFonts.robotoMono(),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Icon(Icons.watch_later_outlined),
                  title: Text('Out Time :'),
                  subtitle: Text(
                    '5:00 PM',
                    style: GoogleFonts.robotoMono(),
                  ),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.only(top: 4, left: 24, right: 24),
          title: Text('Ratings :'),
          trailing: Text(
            '4.5',
            style: GoogleFonts.robotoMono(),
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.only(top: 4, left: 24, right: 24),
          title: Text('Comment :'),
          subtitle: Text(
              'The a have how parents he verbal sight to that there that. The now, together the to presented. We and has digest. Their seriously founded, to were much volume too that screen. Leave farther he away,'),
        ),
      ],
    );
  }
}
