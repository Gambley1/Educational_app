import 'package:educational_app/constants/colors.dart';
import 'package:educational_app/models/subjects_model.dart';
import 'package:educational_app/services/group_service.dart';
import 'package:flutter/material.dart';

import '../models/data_model.dart';
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
  late Future<List<Datum>?> futureListGroup;

  @override
  void initState() {
    futureListGroup = GroupService().getListOfGroups();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Datum>?>(
        // initstate Future<List<Datum>>.GroupService().getListOfGroups() to call it only once per frame
        // futureListGroup is equal to GroupService().getListOfGroups()
        future: futureListGroup,
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
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    centerTitle: false,
                  ),
                ),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => GroupViewModel(
                            data: snapshot.data![index],
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
  final Datum data;
  const GroupViewModel({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LessonScreen(
                      data: data,
                    )));
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
                'Name: ' + data.name!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'year: ' + data.year.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'pantone Value: ' + data.pantoneValue.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
