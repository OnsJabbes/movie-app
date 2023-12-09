import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import the correct library
import '../models/event_detail.dart';

class EventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event'),
      ),
      body: EventList(),
    );
  }
}

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  final FirebaseFirestore db =
      FirebaseFirestore.instance; // Update to the correct class
  List<EventDetail> details = [];

  @override
  void initState() {
    super.initState();
    _loadEventDetails();
  }

  Future<void> _loadEventDetails() async {
    List<EventDetail> loadedDetails = await getDetailsList();

    // Update the state with the loaded event details
    setState(() {
      details = loadedDetails;
    });
  }

  Future<List<EventDetail>> getDetailsList() async {
    var data = await db.collection('event_details').get();

    if (data != null) {
      // Create a list of EventDetail objects using the fromMap constructor
      details = data.docs
          .map((document) =>
              EventDetail.fromMap(document.data() as Map<String, dynamic>))
          .toList();

      // Set the id for each EventDetail
      int i = 0;
      details.forEach((detail) {
        detail.id = data.docs[i].id;
        i++;
      });
    }

    return details;
  }

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
        );
      },
    );
  }
}
