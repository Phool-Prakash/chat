import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'constants.dart';
import 'home_page.dart';
import 'main.dart';

class ZIMKitDemoLoginPage extends StatefulWidget {
  const ZIMKitDemoLoginPage({Key? key}) : super(key: key);

  @override
  State<ZIMKitDemoLoginPage> createState() => _ZIMKitDemoLoginPageState();
}

class _ZIMKitDemoLoginPageState extends State<ZIMKitDemoLoginPage> {
  /// Users who use the same callID can in the same call.
  final userID = TextEditingController(text: '');
  final userName = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();

    // getUniqueUserId().then((_userID) async {
    //   setState(() {
    //     userID.text = _userID;
    //     userName.text = randomName(key: _userID);
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: userID,
                          decoration: InputDecoration(
                              labelText: 'User ID',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: userName,
                          decoration: InputDecoration(
                              labelText: 'User name',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(width: 220, height: 50, child: loginButton()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: () async {
        await ZIMKit()
            .connectUser(
          id: userID.text,
          name: userName.text,
          avatarUrl: 'https://robohash.org/${userID.text}.png?set=set4',
        )
            .then((errorCode) async {
          if (errorCode == 0) {
            /// cache login user info
            final prefs = await SharedPreferences.getInstance();
            prefs.setString(cacheUserIDKey, userID.text);
            currentUser.id = userID.text;
            currentUser.name = userName.text;

            onUserLogin(userID.text, userName.text);
            if (mounted) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const ZIMKitDemoHomePage(),
                ),
              );
            }
          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'login failed, errorCode: $errorCode',
                  ),
                ),
              );
            }
          }
        });
      },
      child: const Text(
        'LogIn',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
