import 'package:email_validator/email_validator.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:movie_app/MovieList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      home: MyHomePage(analytics: analytics, observer: observer),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.analytics, this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _MyHomePageState createState() => _MyHomePageState(analytics, observer);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.analytics, this.observer);
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  FirebaseAuth auth;

  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;

  String email;
  String password;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        auth = FirebaseAuth.instance;
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  Future<void> _sendLogLogin() async {
    await analytics.logEvent(
      name: 'loginEvent',
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if(_error) {
      return Text('Erreur de la connexion à la base de donnée');
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                    'assets/images/home_background.jpg',
                    fit: BoxFit.cover
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.0, 0.65),
                      end: Alignment(0.0, 0.0),
                      colors: <Color>[
                        Colors.black,
                        Color(0x00000000),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Form(
              key: _formKey,
              child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(40,0,40,20),
                      child: Column(
                        children: [
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white30,
                                ),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.teal,
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.account_circle,
                                color: Colors.white,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              var validator = EmailValidator.validate(value);

                              if (validator == null)
                                return "Veuillez entrer une adresse mail valide.";

                              email = value;

                              return null;
                            }
                          ),
                          Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 0)),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Mot de passe",
                              hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white30,
                                ),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.teal,
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.security,
                                color: Colors.white,
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Veuillez entrer votre mot de passe.';
                              }

                              password = value;

                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            try {
                              await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: email,
                                  password: password
                              );

                              _sendLogLogin();

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MovieList()),
                              );
                            } on FirebaseAuthException catch (e) {
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: false, // user must tap button!
                                builder: (BuildContext context) {
                                  return CupertinoAlertDialog(
                                    title: Text('Erreur'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 0)),
                                          Text('Email ou mot de passe incorrect'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },
                        child: Text('Valider'),
                      ),
                    ),
                  ]
              )
          )
        ],
      ),
    );
  }
}
