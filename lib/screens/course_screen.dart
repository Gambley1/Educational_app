import 'package:educational_app/constants/colors.dart';
import 'package:educational_app/models/group_model.dart';
import 'package:educational_app/models/subjects_model.dart';
import 'package:educational_app/screens/details_screen.dart';
import 'package:educational_app/services/group_service.dart';
import 'package:educational_app/services/login_service.dart';
import 'package:flutter/material.dart';

class CourseScreen extends StatefulWidget {
  final Subject subject;
  final Group? group;
  const CourseScreen({
    Key? key,
    this.group,
    required this.subject,
  }) : super(key: key);

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: FutureBuilder<List<Group>?>(
            future: GroupService.getListOfGroups(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return CustomScrollView(slivers: [
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          child: Text(snapshot.data![index].name!),
                        );
                      },
                      childCount: snapshot.data!.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.1,
                    ),
                  ),
                ]);
              }
            }),
      )),
    );
  }
}

class GroupCard extends StatelessWidget {
  final Group group;
  const GroupCard({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 4.0,
                spreadRadius: .05,
              ), //BoxShadow
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 13,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(group.name!, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
