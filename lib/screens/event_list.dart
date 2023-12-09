import 'package:flutter/material.dart';
import '../models/event_detail.dart';
import '../shared/firestore_helper.dart';

class EventList extends StatefulWidget {
  final String uid;

  EventList(this.uid);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  List<EventDetail> details = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: (details != null) ? details.length : 0,
      itemBuilder: (context, position) {
        String sub =
            'Date: ${details[position].date} - Start: ${details[position].startTime} - End: ${details[position].endTime}';
        return ListTile(
          title: Text(details[position].description),
          subtitle: Text(sub),
          trailing: IconButton(
            icon: Icon(Icons.star, color: Colors.grey),
            onPressed: () {
              toggleFavorite(details[position]);
            },
          ),
        );
      },
    );
  }

  void toggleFavorite(EventDetail eventDetail) {
    FirestoreHelper.addFavorite(eventDetail, widget.uid);
  }
}
