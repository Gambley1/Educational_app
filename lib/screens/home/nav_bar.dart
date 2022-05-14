import 'package:educational_app/models/user_model.dart';
import 'package:educational_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../../services/login_service.dart';
import 'home_screen.dart';

class NavBar extends StatefulWidget {
  final UserModel user;
  const NavBar({Key? key, required this.user}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text(
              // '${loggedInUser.email}',
              widget.user.token!,
            ),
            accountName: Text(
              // '${loggedInUser.firstName} ${loggedInUser.secondName}',
              widget.user.email!,
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://cdn.landesa.org/wp-content/uploads/default-user-image.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: NetworkImage(
                      'https://cdn.cbeditz.com/cbeditz/preview/education-powerpoint-background-images-hd-2-11624479925ymmbq73hmy.jpg'),
                  fit: BoxFit.cover,
                )),
          ),
          ListTile(
            leading: const Icon(Icons.analytics_outlined),
            title: const Text('Курсы'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomeScreen(
                      user: widget.user,
                    ))),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Настройки'),
            onTap: () => () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Выйти'),
            onTap: () async {
              final logoutValue = await LoginService().logout();
              if (logoutValue == true) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const LoginScreen()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 3),
                    content: Text(
                      'Error with your token, have to login again',
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
