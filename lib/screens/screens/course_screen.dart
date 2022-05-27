import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../services/services.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class CourseScreen extends StatefulWidget {
  final MySubjectOverall subject;
  final List<MySubjectOverall> subjectOverall;
  final UserModel user;

  const CourseScreen({
    Key? key,
    required this.subject,
    required this.user,
    required this.subjectOverall,
  }) : super(key: key);

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late Future<List<GroupModel>?> futureListOfGroups;
  late Future<List<Lesson>> futureLessons;
  late List<Lesson> currentLessons;

  @override
  void initState() {
    futureListOfGroups = GroupService().getGroups();
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: NavBar(
        user: widget.user,
      ),
      body: FutureBuilderGetLessons(
          futureLessons: futureLessons, size: size, widget: widget),
    );
  }
}

class FutureBuilderGetLessons extends StatelessWidget {
  const FutureBuilderGetLessons({
    Key? key,
    required this.futureLessons,
    required this.size,
    required this.widget,
  }) : super(key: key);

  final Future<List<Lesson>> futureLessons;
  final Size size;
  final CourseScreen widget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Lesson>>(
      future: futureLessons,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverAppBar(
                bottom: PreferredSize(
                  preferredSize: Size.zero,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                    ),
                    height: 1,
                    width: size.width * 100,
                  ),
                ),
                iconTheme: const IconThemeData(color: Colors.black),
                backgroundColor: Colors.transparent,
                elevation: 0,
                floating: false,
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
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => LessonCard(
                          lesson: snapshot.data![index],
                        ),
                    childCount: snapshot.data!.length),
              )
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class LessonCard extends StatelessWidget {
  final Lesson lesson;

  const LessonCard({
    Key? key,
    required this.lesson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
          child: Ink(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.35),
                    // offset: Offset.zero,
                    blurRadius: 6.0,
                    spreadRadius: .05,
                  ),
                ]),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              visualDensity: VisualDensity(horizontal: 0, vertical: 0),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              minVerticalPadding: 30,
              textColor: Colors.black,
              iconColor: Colors.black,
              trailing: const PopUpMenu(isTeacher: true),
              title: Text(
                lesson.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black, fontSize: 21),
              ),
              subtitle: Text(
                lesson.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LessonScreen(
                      isTeacher: true,
                      lesson: lesson,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
