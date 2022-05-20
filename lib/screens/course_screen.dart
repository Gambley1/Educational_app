import 'package:educational_app/constants/colors.dart';
import 'package:educational_app/models/group_model.dart';
import 'package:educational_app/models/lesson_model.dart';
import 'package:educational_app/models/subejct_additional_model.dart';
import 'package:educational_app/screens/lesson_screen.dart';
import 'package:educational_app/services/api_request_service/group_service.dart';
import 'package:educational_app/services/api_request_service/lesson_service.dart';
import 'package:flutter/material.dart';

class CourseScreen extends StatefulWidget {
  final MySubjectOverall subject;

  const CourseScreen({
    Key? key,
    required this.subject,
  }) : super(key: key);

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late Future<List<Group>> futureListOfGroups;
  late Future<List<Lesson>> futureLessons;
  late List<Lesson> currentLessons;

  @override
  void initState() {
    futureListOfGroups = GroupService().getListOfGroups();
    futureLessons =
        LessonService().getListOfLessons(widget.subject.groupSubject.id);
    futureLessons.then((value) {
      setState(() {
        currentLessons = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Lesson>>(
        future: futureLessons,
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
                        text: widget.subject.subject.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    centerTitle: false,
                  ),
                ),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => LessonViewModdel(
                            lesson: snapshot.data![index],
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

class LessonViewModdel extends StatelessWidget {
  final Lesson lesson;

  const LessonViewModdel({
    Key? key,
    required this.lesson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LessonScreen(
              lesson: lesson,
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
                'Name: ' + lesson.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'id: ' + lesson.id.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'created At: ' + lesson.createdDate.split('T')[0],
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
