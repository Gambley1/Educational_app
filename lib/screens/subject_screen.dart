import 'package:educational_app/constants/colors.dart';
import 'package:educational_app/models/subejct_additional_model.dart';
import 'package:educational_app/models/subjects_model.dart';
import 'package:educational_app/models/user_group.dart';
import 'package:educational_app/models/user_model.dart';
import 'package:educational_app/services/group_service.dart';
import 'package:educational_app/services/subject_service.dart';
import 'package:flutter/material.dart';

import '../models/group_model.dart';
import 'course_screen.dart';

class SubjectScreen extends StatefulWidget {
  final List<Group>? group;

  const SubjectScreen({Key? key, this.group}) : super(key: key);

  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  late UserModel user;

  late Future<List<Group>> futureListGroup;
  late Future<Group> futureCurrentGroup;
  late Future<List<MySubjectOverall>> futureMySubjectOverall;
  Group? currentGroup;
  List<MySubjectOverall>? currentMySubjectsOverall;

  @override
  void initState() {
    futureListGroup = GroupService().getListOfGroups();
    futureCurrentGroup = GroupService().getCurrentGroup();
    print("from future user group");
    futureCurrentGroup.then((value){
      setState(() {
        currentGroup = value;
      });
    });
    futureMySubjectOverall = SubjectService().getListOfSubjects();
    futureMySubjectOverall.then((val){
      setState(() {
        currentMySubjectsOverall = val;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: kPrimaryColor,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text:  currentGroup?.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            centerTitle: false,
          ),
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return CategoryCard(
                subject: currentMySubjectsOverall![index],
              );
            },
            childCount: currentMySubjectsOverall!.length,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 10,
            childAspectRatio: 1.1,
          ),
        ),

      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final MySubjectOverall subject;
  final List<Group>? groups;
  final Group? group;

  const CategoryCard({
    Key? key,
    this.group,
    this.groups,
    required this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CourseScreen(
            subject: subject,
          ),
        ),
      ),
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
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/icons/algebra.png",
                  height: 75,
                  width: 75,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(subject.subject.name, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
