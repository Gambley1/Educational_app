import 'package:flutter/material.dart';

import '../../../models/models.dart';
import '../../../services/services.dart';
import '../../screens.dart';

class NavBar extends StatefulWidget {
  final UserModel user;
  const NavBar({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Drawer(
      width: size.width * 0.65,
      child: SingleChildScrollView(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                widget.user.username,
              ),
              accountEmail: Text(
                widget.user.token,
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
                image: DecorationImage(
                  image: NetworkImage(
                      'https://cdn.cbeditz.com/cbeditz/preview/education-powerpoint-background-images-hd-2-11624479925ymmbq73hmy.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.subject_rounded,
                          size: 25,
                        ),
                        title: const Text(
                          'Предметы',
                          style: TextStyle(fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                user: widget.user,
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(
                          Icons.settings,
                          size: 25,
                        ),
                        title: const Text(
                          'Настройки',
                          style: TextStyle(fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        onTap: () => () {},
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(
                          Icons.logout,
                          size: 25,
                        ),
                        title: const Text(
                          'Выйти',
                          maxLines: 1,
                          style: TextStyle(fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () async {
                          final logoutValue = await LogOutService().logout();
                          if (logoutValue == true) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text(
                                  'Error with your data',
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
