import 'package:bruxism/main.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'widgets.dart';
import 'package:intl/intl.dart';

enum ApplicationLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
  alertPage
}

class Authentication extends StatelessWidget {
  const Authentication(
      {required this.loginState,
      required this.email,
      required this.startLoginFlow,
      required this.verifyEmail,
      required this.signInWithEmailAndPassword,
      required this.cancelRegistration,
      required this.registerAccount,
      required this.signOut,
      required this.testFunction});

  final ApplicationLoginState loginState;
  final String? email;
  final void Function() startLoginFlow;
  final void Function(
    String email,
    void Function(Exception e) error,
  ) verifyEmail;
  final void Function(
    String email,
    String password,
    void Function(Exception e) error,
  ) signInWithEmailAndPassword;
  final void Function() cancelRegistration;
  final void Function(
    String email,
    String displayName,
    String password,
    void Function(Exception e) error,
  ) registerAccount;
  final void Function() signOut;
  final void Function(String) testFunction;

  @override
  Widget build(BuildContext context) {
    String _selectedDate = '';
    String _dateCount = '';
    String _range = '';
    String _rangeCount = '';

    late TextEditingController _controller1;
    late TextEditingController _controller2;
    late TextEditingController _controller3;
    late TextEditingController _controller4;
    String _valueChanged1 = '';
    String _valueToValidate1 = '';
    String _valueSaved1 = '';
    String _valueChanged2 = '';
    String _valueToValidate2 = '';
    String _valueSaved2 = '';
    String _valueChanged3 = '';
    String _valueToValidate3 = '';
    String _valueSaved3 = '';
    String _valueChanged4 = '';
    String _valueToValidate4 = '';
    String _valueSaved4 = '';

    _controller1 = TextEditingController(text: DateTime.now().toString());
    _controller2 = TextEditingController(text: DateTime.now().toString());
    _controller3 = TextEditingController(text: DateTime.now().toString());

    String lsHour = TimeOfDay.now().hour.toString().padLeft(2, '0');
    String lsMinute = TimeOfDay.now().minute.toString().padLeft(2, '0');
    _controller4 = TextEditingController(text: '$lsHour:$lsMinute');

    // void _onSelectionChanged(args) {
    //   if (args.value is PickerDateRange) {
    //     _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
    //         // ignore: lines_longer_than_80_chars
    //         ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
    //   } else if (args.value is DateTime) {
    //     _selectedDate = args.value.toString();
    //   } else if (args.value is List<DateTime>) {
    //     _dateCount = args.value.length.toString();
    //   } else {
    //     _rangeCount = args.value.length.toString();
    //   }
    // }

    switch (loginState) {
      case ApplicationLoginState.alertPage:
        TimeOfDay selectedTime = TimeOfDay.now();

        _selectTime(BuildContext context) async {
          final TimeOfDay? timeOfDay = await showTimePicker(
            context: context,
            initialTime: selectedTime,
            initialEntryMode: TimePickerEntryMode.dial,
          );
          if (timeOfDay != null && timeOfDay != selectedTime) {
            selectedTime = timeOfDay;
          }
        }
        return Container(
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                const Text("Which time would you like the Alerts ending up?"),
                ElevatedButton(
                  onPressed: () {
                    _selectTime(context);
                  },
                  child: const Text("Choose Time"),
                ),
                Text("${selectedTime.hour}:${selectedTime.minute}"),
              ],
            ));
      case ApplicationLoginState.loggedOut:
        return Row(
          children: [
            Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 100.00,
                  child: Text(""),
                  height: 100.00,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, bottom: 8),
                  child: StyledButton(
                    onPressed: () {
                      startLoginFlow();
                    },
                    child: const Text('SIGN IN FOR RSVP'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, bottom: 8),
                  child: StyledButton(
                    onPressed: () {
                      startLoginFlow();
                    },
                    child: const Text('REGISTER FOR RSVP'),
                  ),
                )
              ],
            ),
          ],
        );
      case ApplicationLoginState.emailAddress:
        return EmailForm(
            callback: (email) => verifyEmail(
                email, (e) => _showErrorDialog(context, 'Invalid email', e)));
      case ApplicationLoginState.password:
        return PasswordForm(
          email: email!,
          login: (email, password) {
            signInWithEmailAndPassword(email, password,
                (e) => _showErrorDialog(context, 'Failed to sign in', e));
          },
        );
      case ApplicationLoginState.register:
        return RegisterForm(
          email: email!,
          cancel: () {
            cancelRegistration();
          },
          registerAccount: (
            email,
            displayName,
            password,
          ) {
            registerAccount(
                email,
                displayName,
                password,
                (e) =>
                    _showErrorDialog(context, 'Failed to create account', e));
          },
        );
      case ApplicationLoginState.loggedIn:
        return GridView.count(
          primary: false,
          padding: const EdgeInsets.only(left: 10, right: 10),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 2,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 30, left: 0, right: 0),
              child: Column(
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          testFunction("Your Alerts");
                        },
                        icon: const Icon(Icons.settings,
                            color: Colors.white, size: 45),
                      ),
                      const InkWell(
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Text(
                            "Your Alert",
                            style: TextStyle(fontSize: 26),
                          ),
                        )),
                      )
                    ],
                  )
                ],
              ),
              color: Colors.teal[100],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Heed not the rabble'),
              color: Colors.teal[200],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Sound of screams but the'),
              color: Colors.teal[300],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Who scream'),
              color: Colors.teal[400],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Revolution is coming...'),
              color: Colors.teal[500],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Revolution, they...'),
              color: Colors.teal[600],
            ),
          ],
        );

      // Column(
      //   children: [
      //     Card(
      //       elevation: 2.0,
      //       child: Column(
      //         children: [
      //           Row(
      //             children: const [
      //               Padding(
      //                 padding: EdgeInsets.all(10),
      //                 child: Card(elevation: 2.0, child: Text("Text")),
      //               )
      //             ],
      //           )
      //         ],
      //       ),
      //     ),
      //     Card(
      //       elevation: 2.0,
      //       child: Column(
      //         children: [
      //           Row(
      //             children: const [
      //               Padding(
      //                 padding: EdgeInsets.all(10),
      //                 child: Text("Text"),
      //               )
      //             ],
      //           )
      //         ],
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 0, bottom: 8),
      //       child: StyledButton(
      //         onPressed: () {
      //           signOut();
      //         },
      //         child: const Text('LOGOUT'),
      //       ),
      //     ),
      //   ],
      // );
      default:
        return Row(
          children: const [
            Text("Internal error, this shouldn't happen..."),
          ],
        );
    }
  }

  void _showErrorDialog(BuildContext context, String title, Exception e) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${(e as dynamic).message}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            StyledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      },
    );
  }
}

class EmailForm extends StatefulWidget {
  const EmailForm({required this.callback});
  final void Function(String email) callback;
  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_EmailFormState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header('Sign in with email'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your email address to continue';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 30),
                      child: StyledButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            widget.callback(_controller.text);
                          }
                        },
                        child: const Text('NEXT'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    required this.registerAccount,
    required this.cancel,
    required this.email,
  });
  final String email;
  final void Function(String email, String displayName, String password)
      registerAccount;
  final void Function() cancel;
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_RegisterFormState');
  final _emailController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header('Create account'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your email address to continue';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _displayNameController,
                    decoration: const InputDecoration(
                      hintText: 'First & last name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your account name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: widget.cancel,
                        child: const Text('CANCEL'),
                      ),
                      const SizedBox(width: 16),
                      StyledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.registerAccount(
                              _emailController.text,
                              _displayNameController.text,
                              _passwordController.text,
                            );
                          }
                        },
                        child: const Text('SAVE'),
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PasswordForm extends StatefulWidget {
  const PasswordForm({
    required this.login,
    required this.email,
  });
  final String email;
  final void Function(String email, String password) login;
  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_PasswordFormState');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header('Sign in'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your email address to continue';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(width: 16),
                      StyledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.login(
                              _emailController.text,
                              _passwordController.text,
                            );
                          }
                        },
                        child: const Text('SIGN IN'),
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
