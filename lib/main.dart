import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_screen.dart';
import 'package:events/shared/authentication.dart';
import './screens/event_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyAFiT5h4C52i4jjiurSR4tTnjvXXPsS91s',
      authDomain: 'event-d9fd9.firebaseapp.com',
      projectId: 'events-d58cf',
      storageBucket: 'event-d9fd9.appspot.com',
      messagingSenderId: '1092186549123',
      appId: '1:761074351354:android:0e79aee59f7cad5e4d1d43',
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EventScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void testData() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var data = await db.collection('event_details').get();
    var details = data.docs.toList();
    details.forEach((d) {
      print(d.id);
    });
  }

  @override
  void initState() {
    super.initState();
    testData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to the Homepage!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventInformation()),
                );
              },
              child: Text('Show Event Information'),
            ),
          ],
        ),
      ),
    );
  }
}

class EventInformation extends StatefulWidget {
  @override
  EventInformationsState createState() => EventInformationsState();
}

class EventInformationsState extends State<EventInformation> {
  final Stream<QuerySnapshot> _eventsStream =
      FirebaseFirestore.instance.collection('event_details').snapshots();

  @override
  Widget build(BuildContext context) {
    final Authentication auth = new Authentication();
    return Scaffold(
      appBar: AppBar(
        title: Text('Event'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              auth.signOut().then((result) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              });
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _eventsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("Loading"),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> event =
                  document.data()! as Map<String, dynamic>;

              return ListTile(
                title: Text(event['description']),
                subtitle: Text('Speaker: ${event['speaker']}'),
                trailing: Icon(
                  event['is_favorite'] ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
