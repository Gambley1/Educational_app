import 'package:educational_app/constants/colors.dart';
import 'package:educational_app/models/subjects_model.dart';
import 'package:educational_app/models/user_model.dart';
import 'package:flutter/material.dart';

import '../models/group_model.dart';
import 'course_screen.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({Key? key,}) : super(key: key);
 
  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  late UserModel user;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        backgroundColor: kPrimaryColor,
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                TextSpan(
                  text: 'Класс',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 23),
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
              subject: subjectList[index],
            );
          },
          childCount: subjectList.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 10,
          childAspectRatio: 1.1,
        ),
      ),
    ]);
  }
}

class CategoryCard extends StatelessWidget {
  final Subject subject;
  const CategoryCard({
    Key? key,
    required this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CourseScreen(subject: subject,),
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
                  subject.thumbnail,
                  height: 75,
                  width: 75,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(subject.name, style: Theme.of(context).textTheme.bodyLarge),
              Text(
                "${subject.noOfCourses.toString()} курсов",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
