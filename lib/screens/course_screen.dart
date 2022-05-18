import 'package:educational_app/constants/colors.dart';
import 'package:educational_app/models/subjects_model.dart';
import 'package:educational_app/services/get_group_service.dart';
import 'package:flutter/material.dart';

import '../models/group_model.dart';
import 'lesson_screen.dart';

class CourseScreen extends StatefulWidget {
  final Subject? subject;
  const CourseScreen({
    Key? key,
    this.subject,
  }) : super(key: key);

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late Future<List<Group>> futureListOfGroups;

  @override
  void initState() {
    futureListOfGroups = GetGroupService().getListOfGroups();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Group>>(
        future: futureListOfGroups,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: kPrimaryColor,
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: RichText(
                      text: TextSpan(
                        text: widget.subject!.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    centerTitle: false,
                  ),
                ),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => GroupViewModel(
                            group: snapshot.data![index],
                          ),
                      childCount: snapshot.data!.length),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 2.7,
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class GroupViewModel extends StatelessWidget {
  final Group group;
  const GroupViewModel({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LessonScreen(
              group: group,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.35),
                // offset: Offset.zero,
                blurRadius: 4.0,
                spreadRadius: .05,
              ), //BoxShadow
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: ' + group.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'id: ' + group.id.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'created At: ' + group.createdDate.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
