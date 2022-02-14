// ignore_for_file: unnecessary_const

import 'dart:async';
import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart'; // new

import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:firebase_core/firebase_core.dart'; // new

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart'; // new

import 'firebase_options.dart'; // new
import 'src/authentication.dart'; // new

import 'src/widgets.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Meetup',
      theme: ThemeData(
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              highlightColor: Colors.deepPurple,
            ),
        primarySwatch: Colors.deepPurple,
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

int _selectedDestination = 0;

class HomePage extends StatelessWidget {
  // const HomePage({Key? key}) : super(key: key);
  // final GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SliderDrawer(
            appBar: const SliderAppBar(
                appBarColor: Colors.white,
                title: Text(
                  'Bruxism',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                )),
            key: key,
            sliderOpenSize: 179,
            slider: Consumer<ApplicationState>(
              builder: (context, appState, _) => _SliderView(
                onItemClick: appState.testFunction,
                key: key,
              ),
            ),
            child: Column(
              children: [
                _selectedDestination == 0
                    ? Expanded(
                        child: Center(
                          child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              child: Consumer<ApplicationState>(
                                builder: (context, appState, _) =>
                                    Authentication(
                                  loginState: appState.loginState,
                                  email: appState.email,
                                  startLoginFlow: appState.startLoginFlow,
                                  verifyEmail: appState.verifyEmail,
                                  signInWithEmailAndPassword:
                                      appState.signInWithEmailAndPassword,
                                  cancelRegistration:
                                      appState.cancelRegistration,
                                  registerAccount: appState.registerAccount,
                                  signOut: appState.signOut,
                                  testFunction: appState.testFunction,
                                ),
                              )),
                        ),
                      )
                    : const SizedBox(child: Text(""), height: 10)
              ],
            )),
      ),
    );
  }
}

void onmyclick(name) {}

class _SliderView extends StatelessWidget {
  final void Function(String) onItemClick;
  const _SliderView({Key? key, required this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          const CircleAvatar(
            radius: 65,
            backgroundColor: Colors.grey,
            child: CircleAvatar(
                radius: 60, backgroundImage: AssetImage('assets/m.png')),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Nick',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          _SliderMenuItem(
            title: 'Home',
            iconData: Icons.home,
            onTap: onItemClick,
          ),
          const _SliderMenuItem(
            title: 'Your Alerts',
            iconData: Icons.alarm,
            onTap: clickOnTab,
          ),
          const _SliderMenuItem(
            title: 'Evening Diary',
            iconData: Icons.face_retouching_natural_outlined,
            onTap: clickOnTab,
          ),
          const _SliderMenuItem(
            title: 'Charts',
            iconData: Icons.bar_chart,
            onTap: clickOnTab,
          ),
          const _SliderMenuItem(
            title: 'Settings',
            iconData: Icons.settings,
            onTap: clickOnTab2,
          ),
        ],
      ),
    );
  }
}

void oneTime() {}
clickOnTab2(name) {
  _selectedDestination = 2;
}

clickOnTab(name) {
  _selectedDestination = 1;
}

class _SliderMenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function()? onItemClick;
  final Function(String)? onTap;
  const _SliderMenuItem(
      {Key? key,
      required this.title,
      required this.iconData,
      required this.onTap,
      this.onItemClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(
              color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
      leading: Icon(iconData, color: Colors.black),
      onTap: () => onTap?.call(title),
    );
  }
}

class _AuthorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Data> dataList = [];
    dataList.add(Data(Colors.amber, 'Amelia Brown',
        'Life would be a great deal easier if dead things had the decency to remain dead.'));
    dataList.add(Data(Colors.orange, 'Olivia Smith',
        'That proves you are unusual," returned the Scarecrow'));
    dataList.add(Data(Colors.deepOrange, 'Sophia Jones',
        'Her name badge read: Hello! My name is DIE, DEMIGOD SCUM!'));
    dataList.add(Data(Colors.red, 'Isabella Johnson',
        'I am about as intimidating as a butterfly.'));
    dataList.add(Data(Colors.purple, 'Emily Taylor',
        'Never ask an elf for help; they might decide your better off dead, eh?'));
    dataList.add(Data(Colors.green, 'Maya Thomas', 'Act first, explain later'));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.separated(
          scrollDirection: Axis.vertical,
          //   physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          itemBuilder: (builder, index) {
            return LimitedBox(
              maxHeight: 150,
              child: Container(
                decoration: BoxDecoration(
                    color: dataList[index].color,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    )),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        dataList[index].name,
                        style: const TextStyle(
                            fontFamily: 'BalsamiqSans_Blod',
                            fontSize: 30,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        dataList[index].detail,
                        style: const TextStyle(
                            fontFamily: 'BalsamiqSans_Regular',
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (builder, index) {
            return const Divider(
              height: 10,
              thickness: 0,
            );
          },
          itemCount: dataList.length),
    );
  }
}

class Data {
  MaterialColor color;
  String name;
  String detail;
  Data(this.color, this.name, this.detail);
}

class ColoursHelper {
  static Color blue() => const Color(0xff5e6ceb);
  static Color blueDark() => const Color(0xff4D5DFB);
}

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }
  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        _guestBookSubscription = FirebaseFirestore.instance
            .collection('guestbook')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
          // _guestBookMessages = [];
          // for (final document in snapshot.docs) {
          //   _guestBookMessages.add(
          //     GuestBookMessage(
          //       name: document.data()['name'] as String,
          //       message: document.data()['text'] as String,
          //     ),
          //   );
          // }
          notifyListeners();
        });
      } else {
        _loginState = ApplicationLoginState.loggedOut;
        // _guestBookMessages = [];
        _guestBookSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;
  String? _email;
  String? get email => _email;

  StreamSubscription<QuerySnapshot>? _guestBookSubscription;
  // List<GuestBookMessage> _guestBookMessages = [];
  // List<GuestBookMessage> get guestBookMessages => _guestBookMessages;

  void startLoginFlow() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  void testFunction(name) {
    switch (name) {
      case 'Home':
        //back to home
        break;
      case 'Your Alerts':
        //set the alert
        _loginState = ApplicationLoginState.alertPage;
        print("show alert");
        notifyListeners();

        break;
      case 'Evening Diary':
        // list the alert
        break;
      case 'Charts':
        break;
      case 'Settings':
        break;

      default:
        break;
    }
    //startLoginFlow();
  }

  Future<void> verifyEmail(
    String email,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        _loginState = ApplicationLoginState.password;
      } else {
        _loginState = ApplicationLoginState.register;
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void cancelRegistration() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  Future<void> registerAccount(
      String email,
      String displayName,
      String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<DocumentReference> addMessageToGuestBook(String message) {
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('guestbook')
        .add(<String, dynamic>{
      'text': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }
}
